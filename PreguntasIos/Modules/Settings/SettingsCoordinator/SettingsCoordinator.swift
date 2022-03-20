//
//  SettingsCoordinator.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 14/3/22.
//

import Foundation

final class SettingsCoordinator: ObservableObject, Identifiable {
    @Published private (set) var settings: AppSettings

    @Published var playersSetupViewModel: PlayersSetupViewModel?
    @Published var languageViewModel: LanguageViewModel?
    @Published var appFeedbackViewModel: AppFeedbackViewModel?
    @Published var openedURL: URL?

    private let gameAPIService: GameApiService

    init(gameAPIService: GameApiService) {
        self.gameAPIService = gameAPIService
        self.settings = AppSettings(profile: AppSettings.ProfileSettings.allCases,
                                    more: AppSettings.MoreSettings.allCases)
    }

    func profileSettingSelected(_ profileSetting: AppSettings.ProfileSettings) {
        switch profileSetting {
        case .players: playersSetupViewModel = PlayersSetupViewModel()
        case .language: languageViewModel = LanguageViewModel()
        }
    }

    func moreSettingSelected(_ moreSetting: AppSettings.MoreSettings) {
        switch moreSetting {
        case .termsAndConditions:
            if let url = URL(string: "https://www.google.com") {
                open(url)
            }
        case .privacyPolicy:
            if let url = URL(string: "https://www.facebook.com") {
                open(url)
            }
        case .feedback:
            appFeedbackViewModel = AppFeedbackViewModel(gameAPIService: gameAPIService)
        }
    }

    private func open(_ url: URL) {
        self.openedURL = url
    }

    deinit {
        print("SettingsCoordinator deinit 🗑")
    }
}
