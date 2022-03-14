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

    init() {
        self.settings = AppSettings(profile: AppSettings.ProfileSettings.allCases)
    }

    func profileSettingSelected(_ profileSetting: AppSettings.ProfileSettings) {
        switch profileSetting {
        case .players: playersSetupViewModel = PlayersSetupViewModel()
        case .language: languageViewModel = LanguageViewModel()
        }
    }

//    func membershipSettingSelected(_ membershipSetting: AppSettings.MembershipSettings) {
//        print("Membership setting selected: \(membershipSetting.rawValue)")
//    }
//
//    func moreSettingSelected(_ moreSetting: AppSettings.MoreSettings) {
//        print("More setting selected: \(moreSetting.rawValue)")
//    }

    deinit {
        print("SettingsCoordinator deinit 🗑")
    }
}
