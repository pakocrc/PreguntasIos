//
//  GameApiClient.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 25/2/22.
//

import Combine
import Foundation

protocol GameApiService {
    func getQuestions() -> AnyPublisher<Questions, APIError>
    func gameStarted(players: [Player], language: Language) -> AnyPublisher<String, APIError>
    func suggestQuestion(question: String, language: Language, user: String) -> AnyPublisher<String, APIError>
    func questionFeedback(feedbackType: FeedbackType,
                          feedback: String,
                          question: String,
                          language: Language) -> AnyPublisher<String, APIError>
    func appFeedback(feedback: String,
                     appExperienceType: AppExperienceType,
                     language: Language) -> AnyPublisher<String, APIError>
}

final class GameApiClient: GameApiService {
    func getQuestions() -> AnyPublisher<Questions, APIError> {
        request(.getQuestions)
    }

    func gameStarted(players: [Player], language: Language) -> AnyPublisher<String, APIError> {
        request(.gameStarted(players: players, language: language))
    }

    func suggestQuestion(question: String, language: Language, user: String) -> AnyPublisher<String, APIError> {
        request(.suggestQuestion(question: question, language: language, user: user))
    }

    func questionFeedback(feedbackType: FeedbackType,
                          feedback: String,
                          question: String,
                          language: Language) -> AnyPublisher<String, APIError> {
        request(.questionFeedback(feedbackType: feedbackType,
                                  feedback: feedback,
                                  question: question,
                                  language: language))
    }

    func appFeedback(feedback: String,
                     appExperienceType: AppExperienceType,
                     language: Language) -> AnyPublisher<String, APIError> {
        request(.appFeedback(feedback: feedback, appExperienceType: appExperienceType, language: language))
    }
}

extension GameApiClient {
    // MARK: - Request Methods
    private func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, APIError> {
        do {
            let request = try endpoint.request()

            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response -> T in

                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                        throw APIError.failedRequest
                    }

                    guard (200..<300).contains(statusCode) else {
                        if statusCode == 401 {
                            throw APIError.unauthorized
                        } else if statusCode == 404 {
                            throw APIError.unreachable
                        } else {
                            throw APIError.failedRequest
                        }
                    }

                    do {
                        return try JSONDecoder().decode(T.self, from: data)
                    } catch {
                        print("❌ [GameAPIClient] [request()] Unable to Decode Response \(error)")
                        throw APIError.invalidResponse
                    }
                }
                .mapError { error -> APIError in
                    switch error {
                    case let apiError as APIError:
                        return apiError
                    case URLError.notConnectedToInternet:
                        return APIError.unreachable
                    default:
                        return APIError.failedRequest
                    }
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch {
            if let apiError = error as? APIError {
                return Fail(error: apiError)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: APIError.unknown)
                    .eraseToAnyPublisher()
            }
        }
    }
}
