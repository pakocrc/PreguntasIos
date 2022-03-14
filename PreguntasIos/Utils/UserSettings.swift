//
//  UserSettings.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 9/3/22.
//

import Foundation

struct UserSettings {
    private let userDefaults = UserDefaults.standard

    var players: [Player] {
        get {
            guard let userListFromUserDefaults = userDefaults.value(forKey: "users") as? String else {
                return []
            }

            return userListFromUserDefaults.split(separator: ",").map({ return Player(name: $0.description) })
        }

        set {
            let userListString = newValue.reduce("") { "\($0)\($1.name)," }
            userDefaults.setValue(userListString, forKey: "users")
        }
    }

    var preferedLanguage: Language {
        get {
            let preferedLanguageFromUserDefaults = userDefaults.value(forKey: "preferedLanguage") as? String
            ?? (Locale.current.languageCode ?? "es")

            switch preferedLanguageFromUserDefaults {
            case "en": return .en
            case "es": return .es
            case "de": return .de
            case "fr": return .fr
            case "pt": return .pt
            default: return .es
            }
        }

        set {
            var newPreferedLanguage: String

            switch newValue {
            case .en: newPreferedLanguage = "en"
            case .es: newPreferedLanguage = "es"
            case .de: newPreferedLanguage = "de"
            case .fr: newPreferedLanguage = "fr"
            case .pt: newPreferedLanguage = "pt"
            }

            userDefaults.setValue(newPreferedLanguage, forKey: "preferedLanguage")
        }
    }

    var likedQuestions: [String] {
        get {
            return userDefaults.value(forKey: "likedQuestions") as? [String] ?? []
        }

        set {
            if let newLikedQuestion = newValue.last {
                var currentLikedQuestions = userDefaults.value(forKey: "likedQuestions") as? [String] ?? []

                if !currentLikedQuestions.contains(where: { $0 == newLikedQuestion }) {
                    currentLikedQuestions.append(newLikedQuestion)

                } else {
                    currentLikedQuestions.removeAll(where: { $0 == newLikedQuestion })
                }

                userDefaults.set(currentLikedQuestions, forKey: "likedQuestions")
            }
        }
    }
}
