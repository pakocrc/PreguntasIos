//
//  SuggestQuestionViewModel.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 13/3/22.
//

import Combine
import Foundation

final class SuggestQuestionViewModel: ObservableObject, Identifiable {

    private let gameAPIService: GameApiService
    private var cancellables = Set<AnyCancellable>()

    @Published var loading = false
    @Published var dismissView = false

    // MARK: Error
    @Published private (set) var errorMessage: String?
    @Published var showErrorMessage = false

    init(gameAPIService: GameApiService) {
        self.gameAPIService = gameAPIService
    }

    func setQuestion(question: String) {
        print("Question: \(question)")
    }

    func setUser(user: String) {
        print("User: \(user)")
    }

    func sendButtonPressed(question: String, user: String) {
        loading = true
        gameAPIService.suggestQuestion(question: question,
                                       language: UserSettings().preferedLanguage,
                                       user: !user.isEmpty ? user : "Anonymous")
            .sink(receiveCompletion: { [weak self] completion in

                self?.loading = false

                switch completion {
                case .failure(let error):
                    print("🔴 Unable to send suggested question. Error: \(error)")
                    self?.errorMessage = NSLocalizedString("suggest_question_view_error", comment: "")
                    self?.showErrorMessage = true
                default: break
                }
            }, receiveValue: { [weak self] result in
                print("🟠 Question suggested! \(result)")
                self?.dismissView = true
            })
            .store(in: &cancellables)
    }

    deinit {
        print("SuggestQuestionViewModel deinit 🗑")
    }
}
