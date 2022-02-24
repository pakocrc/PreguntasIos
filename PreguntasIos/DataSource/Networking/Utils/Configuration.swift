//
//  Configuration.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

import Foundation

enum Configuration: String {
    case debug, release

    static let current: Configuration = {
        guard let rawValue = Bundle.main.infoDictionary?["Configuration"] as? String else {
            fatalError("No configuration found")
        }

        guard let configuration = Configuration(rawValue: rawValue.lowercased()) else {
            fatalError("Invalid configuration")
        }

        return configuration
    }()

    static var baseURL: URL {
        switch current {
        case .debug:
            return URL(string: "https://sfge2zkyh3.execute-api.us-east-1.amazonaws.com/")!
        case .release:
            return URL(string: "https://sfge2zkyh3.execute-api.us-east-1.amazonaws.com/")!
        }
    }
}
