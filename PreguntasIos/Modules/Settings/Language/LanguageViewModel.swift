//
//  LanguageViewModel.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 14/3/22.
//

import Foundation

final class LanguageViewModel: ObservableObject {
    @Published var preferedLanguage = UserSettings().preferedLanguage

    // MARK: Alert and Error
    @Published private (set) var alertMessage: String?
    @Published var showAlertMessage = false

    private var newLanguage: Language?

    func setLanguage(language: Language) {
        newLanguage = language

        alertMessage = "language_view_confirm_language_change".localized()
        showAlertMessage = true
    }

    func setLanguageConfirmed() {
        if let newLanguage = newLanguage {
            var userSettings = UserSettings()
            userSettings.preferedLanguage = newLanguage
            preferedLanguage = newLanguage
        }
    }
}
