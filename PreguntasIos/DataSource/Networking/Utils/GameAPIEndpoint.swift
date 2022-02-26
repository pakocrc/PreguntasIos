//
//  GameAPIEndpoint.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 24/2/22.
//

import Foundation

enum APIEndpoint {

    // MARK: - Cases
//    case auth(email: String, password: String)
    case getQuestions

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

//        if requiresAuthorization {
//            if let accessToken = accessToken {
//                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//            } else {
//                throw APIError.unauthorized
//            }
//        }

        request.httpBody = httpBody

        return request
    }

    private var url: URL {
        Environment.baseURL.appendingPathComponent(path)
    }

    private var path: String {
        switch self {
        case .getQuestions:
            return "/PreguntasFunc"
//        case .auth:
//            return "auth"
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
//        case .auth,
//             .updateVideoProgress:
//            return .post
//        case .episodes,
//             .video,
//             .videoProgress:
//            return .get
//        case .deleteVideoProgress:
//            return .delete
        }
    }

    private var httpBody: Data? {
//        switch self {
//        case let .updateVideoProgress(id: _, cursor: cursor):
//            let body = UpdateVideoProgressBody(cursor: cursor)
//            return try? JSONEncoder().encode(body)
//        case .auth,
//             .episodes,
//             .video,
//             .videoProgress,
//             .deleteVideoProgress:
            return nil
//        }
    }

//    private var requiresAuthorization: Bool {
//        switch self {
//        case .auth,
//                .episodes:
//            return false
//        case .video,
//             .videoProgress,
//             .updateVideoProgress,
//             .deleteVideoProgress:
//            return true
//        }
//    }

    private var headers: HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
//            "X-API-TOKEN": Environment.apiToken
        ]

//        if case let .auth(email: email, password: password) = self {
//            let authData = (email + ":" + password).data(using: .utf8)!
//            let encodedAuthData = authData.base64EncodedString()
//            headers["Authorization"] = "Basic \(encodedAuthData)"
//        }
//
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
