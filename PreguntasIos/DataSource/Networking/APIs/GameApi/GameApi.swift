//
//  GameApi.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

import Foundation

public enum GameApiEndpoint {
    case getCategories
    case getQuestions
}

extension GameApiEndpoint: EndPointType {
    private var environmentBaseURL: String {
        return Configuration.baseURL.description

//        switch self {
//        case .getQuestions:
//            return baseUrl.append(contentsOf: "items")
//        default:
//            break
//        }

//        return baseUrl
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var locale: String {
        return NSLocale.current.languageCode ?? "en"
    }

    var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }

    var path: String {
        switch self {
        case .getQuestions:
            return "items"
        default:
            return ""
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        switch self {
        case .getQuestions:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: nil)
        default:
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: nil)
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}
