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
    case questionFeedback(feedbackType: FeedbackType, feedback: String, question: String, language: Language)
    case appFeedback(feedback: String, appExperienceType: AppExperienceType, language: Language)

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
            return "question/suggest"
        case .questionFeedback:
            return "feedback/question"
        case .appFeedback:
            return "feedback/app"
        }
    }

    private var httpMethod: HTTPMethod {
        switch self {
        case .getQuestions:
            return .get
        case .gameStarted:
            return .put
        case .suggestQuestion, .questionFeedback, .appFeedback:
            return .post
        }
    }

    private var httpBody: Data? {
        switch self {
        case .gameStarted(let players, let language):
            let jsonString: [String: Any] = [
                "players": players.reduce("") { "\($0)\($1.name), " },
                "count": players.count.description,
                "lang": language.rawValue
            ]
            return try? JSONSerialization.data(withJSONObject: jsonString)

        case .suggestQuestion(let question, let language, let user):
            let jsonString: [String: Any] = [
                "question": question,
                "user": user,
                "lang": language.rawValue
            ]
            return try? JSONSerialization.data(withJSONObject: jsonString)

        case .questionFeedback(let feedbackType, let feedback, let question, let language):
            let jsonString: [String: Any] = [
                "type": feedbackType.rawValue,
                "feedback": feedback,
                "question": question,
                "lang": language.rawValue
            ]
            return try? JSONSerialization.data(withJSONObject: jsonString)
        case .appFeedback(let feedback, let appExperienceType, let language):
            let jsonString: [String: Any] = [
                "feedback": feedback,
                "experience": appExperienceType.rawValue,
                "lang": language.rawValue
            ]
            return try? JSONSerialization.data(withJSONObject: jsonString)
        default:
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
