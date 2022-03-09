//
//  EnvironmentConfig.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

import Foundation

enum EnvironmentConfig: String {
    case staging, production

    static let current: EnvironmentConfig = {
        guard let rawValue = Bundle.main.infoDictionary?["Environment"] as? String else {
            fatalError("No environment found")
        }

        guard let environment = EnvironmentConfig(rawValue: rawValue.lowercased()) else {
            fatalError("Invalid environment")
        }

        return environment
    }()

    static var baseURL: URL {
        switch current {
        case .staging:
            return URL(string: "https://sfge2zkyh3.execute-api.us-east-1.amazonaws.com/")!
        case .production:
            return URL(string: "https://sfge2zkyh3.execute-api.us-east-1.amazonaws.com/")!
        }
    }
}
