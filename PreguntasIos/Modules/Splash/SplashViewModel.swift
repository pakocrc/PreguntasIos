//
//  SplashViewModel.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

import Combine
import Foundation
import SwiftUI

final class SplashViewModel: ObservableObject {
    private let apiClient: GameApiClient

    @Published private (set) var questions: Questions?
    @Published private (set) var dataLoaded = false
    @Published private (set) var errorMessage: String?
    @Published var showErrorMessage = false

    private var cancellables = Set<AnyCancellable>()

    init(apiClient: GameApiClient) {
        self.apiClient = apiClient

        self.loadData()

        self.$questions
            .filter({ !($0?.questions.isEmpty ?? true) && !($0?.categories.isEmpty ?? true) })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: ()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] result in
                if let categories = result?.categories, !categories.isEmpty,
                   let questions = result?.questions, !questions.isEmpty {
                    self?.dataLoaded.toggle()
                }
            }).store(in: &cancellables)
    }

    // MARK: - Helpers
    func loadData() {
        loadMockData()
//        loadInitialData()
    }

    private func loadInitialData() {
        print("🟠 Loading server data...")
        apiClient.getQuestions()
            .sink(receiveCompletion: { [weak self] completion in

                switch completion {
                case .failure(let error):
                    print("Unable to fetch information. Error: \(error)")

                    self?.errorMessage = APIErrorMapper(error: error).message
                    self?.showErrorMessage = true

                default: break
                }
            }, receiveValue: { [weak self] result in
                DispatchQueue.main.async {
                    var categories = result.categories
                    categories.append(contentsOf: [.mixed, .all, .liked])

                    self?.questions = Questions(questions: result.questions, categories: categories)
                }
            }).store(in: &cancellables)
    }

    private func loadMockData() {
        print("🟠 Loading mock data...")
        guard let url = Bundle.main.url(forResource: "preguntas", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode(Questions.self, from: data) else {
                  let errorMsj = "Unable to load or parse preguntas.json"
                  print(errorMsj)
                  self.showErrorMessage = true
                  self.errorMessage = errorMsj
                  return
              }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            var categories = response.categories
            categories.append(contentsOf: [.mixed, .all, .liked])

            self?.questions = Questions(questions: response.questions, categories: categories)
        }
    }

    deinit {
        print("SplashViewModel deinit 🗑")
    }
}
