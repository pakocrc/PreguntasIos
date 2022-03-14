//
//  GameAPIEndpoint.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 24/2/22.
//

import Foundation

enum APIEndpoint {
    case getQuestions
    case gameStarted(players: [Player], language: Language)
    case suggestQuestion(question: String, language: Language, user: String)

    //    case episodes
    //    case video(id: String)
    //    case videoProgress(id: String)
    //    case updateVideoProgress(id: String, cursor: Int)
    //    case deleteVideoProgress(id: String)

    // MARK: - Properties
    func request() throws -> URLRequest {
        var request = URLRequest(url: url)

        request.addHeaders(headers)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = httpBody

        return request
    }

    private var url: URL {
        EnvironmentConfig.baseURL.appendingPathComponent(path)
    }

    private var path: String {
        switch self {
        case .getQuestions:
            return "PreguntasFunc"
        case .gameStarted:
            return "game"
        case .suggestQuestion:
            return "suggestion"
            //        case .episodes:
            //            return "episodes"
            //        case let .video(id: id):
            //            return "videos/\(id)"
            //        case let .videoProgress(id: id),
            //             let .updateVideoProgress(id: id, cursor: _),
            //             let .deleteVideoProgress(id: id):
            //            return "videos/\(id)/progress"
        }
    }

    private var httpMethod: HTTPMethod {
        switch self {
        case .getQuestions:
            return .get
        case .gameStarted:
            return .put
        case .suggestQuestion:
            return .post
        }
    }

    private var httpBody: Data? {
        switch self {
        case .gameStarted(let players, let language):
            let jsonString: [String: Any] = ["players": players.reduce("") { "\($0)\($1.name), " },
                                             "count": players.count.description,
                                             "lang": language.rawValue]
            return try? JSONSerialization.data(withJSONObject: jsonString)

        case .suggestQuestion(let question, let language, let user):
            let jsonString: [String: Any] = ["question": question,
                                             "user": user,
                                             "lang": language.rawValue]
            return try? JSONSerialization.data(withJSONObject: jsonString)

        default:
            //        case let .updateVideoProgress(id: _, cursor: cursor):
            //            let body = UpdateVideoProgressBody(cursor: cursor)
            //            return try? JSONEncoder().encode(body)
            //        case .auth,
            //             .episodes,
            //             .video,
            //             .videoProgress,
            //             .deleteVideoProgress:
            return nil
        }
    }

    private var headers: HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        return headers
    }

}

extension URLRequest {
    mutating func addHeaders(_ headers: HTTPHeaders) {
        headers.forEach { header, value in
            addValue(value, forHTTPHeaderField: header)
        }
    }
}
