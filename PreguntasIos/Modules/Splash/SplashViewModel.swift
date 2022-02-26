//
//  SplashViewModel.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

import Combine
import Foundation
import SwiftUI

class SplashViewModel: ObservableObject {
    //    private let questionsUseCase = QuestionsUseCase()
    private let apiClient: GameAPIClient

    @Published private (set) var categories: [QuestionCategory]?
    @Published private (set) var questions: [Question]?
    @Published private (set) var dataLoaded = false
    @Published private (set) var errorMessage: String?
    @Published var showErrorMessage = false

    private var cancellables = Set<AnyCancellable>()

    init(apiClient: GameAPIClient) {
        self.apiClient = apiClient

        // loadDataMock()
        loadData()

        self.$categories.combineLatest(self.$questions)
            .filter({ !($0.0?.isEmpty ?? true) && !($0.1?.isEmpty ?? true) })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: ()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] result in
                if let categories = result.0, !categories.isEmpty,
                   let questions = result.1, !questions.isEmpty {
                    self?.dataLoaded.toggle()
                }
            }).store(in: &cancellables)
    }

    func loadData() {
        self.apiClient.getQuestions()
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
                    self?.questions = result.questions
                    self?.categories = result.categories
                }
            }).store(in: &cancellables)
    }

    private func loadDataMock() {
        guard let url = Bundle.main.url(forResource: "preguntas", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let preguntas = try? JSONDecoder().decode([Question].self, from: data) else {
                  print("Unable to load or parse preguntas.json")
                  return
              }

        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in

            DispatchQueue.main.async {
                self?.questions = preguntas
                self?.categories = [QuestionCategory.friends, QuestionCategory.life, QuestionCategory.dirty]
            }
        }
    }
}
