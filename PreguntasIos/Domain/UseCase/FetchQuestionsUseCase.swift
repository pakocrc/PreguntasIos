//
//  FetchQuestionsUseCase.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

import Combine

class FetchQuestionsUseCase {
    private let networkManager = NetworkManager<GameApiEndpoint>()

//    func execute() -> AnyPublisher<Questions, NetworkResponse> {
//        return AnyPublisher<Questions, NetworkResponse>.create { [weak self] promise in
//            guard let `self` = self else { return Disposable() }
//
//            self.moviesApi()
//                .sink(receiveCompletion: { [weak self] networkResponse in
//                    guard let `self` = self else { return }
//                    switch networkResponse {
//                    case .failure(let response):
//                        let newNetworkResponse = self.handleNetworkResponse(networkResponseApi: response)
//                        promise.onError(newNetworkResponse)
//                    default: break
//                    }
//                }, receiveValue: { apiResponse in
//                    let response = Movies(apiResponse: apiResponse)
//                    promise.onNext(response)
//                }).store(in: &self.cancellable)
//
//            return Disposable()
//        }
//    }
}

/*
// Game
    @Throws(Exception::class)
    suspend fun getQuestions(): List<Question>
    fun likeQuestion(question: Question)
    fun dislikeQuestion(question: Question, feedbackSatisfaction: FeedbackSatisfaction, feedback: String?)
    fun sendQuestionFeedback(question: Question, feedbackType: FeedbackType, feedback: String?)
    fun startGame(players: Int, category: QuestionCategory): Unit

    // Settings
    fun setLanguage(language: Language)
    fun setPlayers(players: Int)
    fun tryPremium()
    fun restorePurchase()
    fun rateApp()
    fun sendAppFeedback()
    fun termsAndConditions()
    fun privacyPolicy()
*/
