//
//  QuestionFeedbackViewModel.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 13/3/22.
//

import Combine
import Foundation

final class QuestionFeedbackViewModel: ObservableObject, Identifiable {
    private let gameAPIService: GameApiService
    private let question: Question

    private var cancellables = Set<AnyCancellable>()

    @Published var loading: Bool = false

    // MARK: Alert and Error
    @Published private (set) var alertMessage: String?
    @Published var showErrorMessage = false
    @Published var showAlertMessage = false

    @Published var dismissView = false

    init(gameAPIService: GameApiService, question: Question) {
        self.gameAPIService = gameAPIService
        self.question = question
    }

    func dismissViewAction() {
        dismissView = true
    }

    func sendButtonPressed(feedbackType: FeedbackType?, feedback: String) {
        guard let feedbackType = feedbackType else { return }

        loading = true

        gameAPIService.questionFeedback(feedbackType: feedbackType,
                                        feedback: feedback,
                                        question: question.id,
                                        language: UserSettings().preferedLanguage)
            .sink(receiveCompletion: { [weak self] completion in

                self?.loading = false

                switch completion {
                case .failure(let error):
                    print("🔴 Unable to send question feedback. Error: \(error)")
                    self?.alertMessage = NSLocalizedString("question_feedback_view_error", comment: "")
                    self?.showErrorMessage = true
                default: break
                }
            }, receiveValue: { [weak self] result in
                print("🟠 Question feedback sent! \(result)")
                self?.showAlertMessage = true
                self?.alertMessage = NSLocalizedString("question_feedback_view_success", comment: "")
            })
            .store(in: &cancellables)
    }

    deinit {
        print("QuestionFeedbackViewModel deinit 🗑")
    }
}
