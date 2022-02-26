//
//  GameApiService.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 24/2/22.
//

import Combine

protocol GameApiService {
    func getQuestions() -> AnyPublisher<Questions, APIError>
//    func likeQuestion(question: Question) -> AnyPublisher<Void, APIError>
//    func dislikeQuestion(question: Question,
//                         feedbackSatisfaction: FeedbackSatisfaction,
//                         feedback: String?) -> AnyPublisher<Void, APIError>
//    func sendQuestionFeedback(question: Question,
//                              feedbackType: FeedbackType,
//                              feedback: String?) -> AnyPublisher<Void, APIError>
//    func startGame(players: Int, category: QuestionCategory) -> AnyPublisher<Void, APIError>
}
