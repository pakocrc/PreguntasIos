//
//  String+Localized.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 14/3/22.
//

import Foundation

extension String {
    func localized() -> String {
        if let path = Bundle.main.path(forResource: UserSettings().preferedLanguage.rawValue, ofType: "lproj") {
            let bundle = Bundle(path: path)
            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        }

        return ""
    }
}
