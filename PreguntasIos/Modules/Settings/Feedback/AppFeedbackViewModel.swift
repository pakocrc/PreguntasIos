//
//  AppFeedbackViewModel.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 19/3/22.
//

import Combine
import Foundation

final class AppFeedbackViewModel: ObservableObject, Identifiable {
    private let gameAPIService: GameApiService

    private var cancellables = Set<AnyCancellable>()

    @Published var loading: Bool = false

    // MARK: Alert and Error
    @Published private (set) var alertMessage: String?
    @Published var showErrorMessage = false
    @Published var showAlertMessage = false

    @Published var dismissView = false

    init(gameAPIService: GameApiService) {
        self.gameAPIService = gameAPIService
    }

    func dismissViewAction() {
        dismissView = true
    }

    func sendButtonPressed(feedback: String, appExperienceType: AppExperienceType) {
        loading = true

        gameAPIService.appFeedback(feedback: feedback,
                                   appExperienceType: appExperienceType,
                                   language: UserSettings().preferedLanguage)
            .sink(receiveCompletion: { [weak self] completion in

                self?.loading = false

                switch completion {
                case .failure(let error):
                    print("🔴 Unable to send app feedback. Error: \(error)")
                    self?.alertMessage = "app_feedback_view_error".localized()
                    self?.showErrorMessage = true
                default: break
                }
            }, receiveValue: { [weak self] result in
                print("🟠 App feedback sent! \(result)")
                self?.showAlertMessage = true
                self?.alertMessage = "app_feedback_view_success".localized()
            })
            .store(in: &cancellables)
    }

    deinit {
        print("AppFeedbackViewModel deinit 🗑")
    }
}
