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

    // MARK: Alert and Error
    @Published private (set) var alertMessage: String?
    @Published var showErrorMessage = false
    @Published var showAlertMessage = false

    init(gameAPIService: GameApiService) {
        self.gameAPIService = gameAPIService
    }

    func sendButtonPressed(question: String, user: String?, flag: String?) {
        loading = true
        gameAPIService.suggestQuestion(question: question,
                                       language: UserSettings().preferedLanguage,
                                       user: "\(user ?? "Anonymous") - \(flag ?? "🏴‍☠️")")
            .sink(receiveCompletion: { [weak self] completion in

                self?.loading = false

                switch completion {
                case .failure(let error):
                    print("🔴 Unable to send suggested question. Error: \(error)")
                    self?.alertMessage = "suggest_question_view_error".localized()
                    self?.showErrorMessage = true
                default: break
                }
            }, receiveValue: { [weak self] result in
                print("🟠 Question suggested! \(result)")
                self?.showAlertMessage = true
                self?.alertMessage = "suggest_question_view_success".localized()
            })
            .store(in: &cancellables)
    }

    func dismissViewAction() {
        dismissView = true
    }

    deinit {
        print("SuggestQuestionViewModel deinit 🗑")
    }
}
