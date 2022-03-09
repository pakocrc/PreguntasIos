//
//  SettingsViewModel.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 27/2/22.
//

import Foundation
import SwiftUI

struct AppSettings {
    enum ProfileSettings: String, CaseIterable {
        case players = "settings_profile_players", language = "settings_profile_language"
    }

    enum MembershipSettings: String, CaseIterable {
        case premium = "settings_membership_premium", restorePurchase = "settings_membership_restore_purchase"
    }

    enum MoreSettings: String, CaseIterable {
        case rateApp = "settings_more_rate_app",
             feedback = "settings_more_feedback",
             termsAndConditions = "settings_more_terms_and_conditions",
             privacyPolicy = "settings_more_privacy_policy"
    }

    let profile: [ProfileSettings]
    let membership: [MembershipSettings]
    let more: [MoreSettings]
}

final class SettingsViewModel: ObservableObject, Identifiable {
    let id = UUID().uuidString
    @Published private (set) var settings: AppSettings

    init() {
        self.settings = AppSettings(profile: AppSettings.ProfileSettings.allCases,
                                    membership: AppSettings.MembershipSettings.allCases,
                                    more: AppSettings.MoreSettings.allCases)
    }

    func profileSettingSelected(_ profileSetting: AppSettings.ProfileSettings) {
        print("Profile setting selected: \(profileSetting.rawValue)")
    }

    func membershipSettingSelected(_ membershipSetting: AppSettings.MembershipSettings) {
        print("Membership setting selected: \(membershipSetting.rawValue)")
    }

    func moreSettingSelected(_ moreSetting: AppSettings.MoreSettings) {
        print("More setting selected: \(moreSetting.rawValue)")
    }

    deinit {
        print("SettingsViewModel deinit 🗑")
    }
}
