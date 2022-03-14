//
//  AppSettings.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 14/3/22.
//

import Foundation

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
//    let membership: [MembershipSettings]
//    let more: [MoreSettings]
}
