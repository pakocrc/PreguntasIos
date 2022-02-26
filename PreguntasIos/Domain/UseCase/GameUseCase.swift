//
//  GameUseCase.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

import Combine
import Foundation

protocol GameUseCaseProtocol {
    func getQuestions()
}

class GameUseCase {
    private var cancellables = Set<AnyCancellable>()

    func getQuestions() {
        guard var url = URL(string: Environment.baseURL.description)
        else { return }

        url.appendPathComponent("/PreguntasFunc")

        let request = URLRequest(url: url)

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Questions.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in

                switch completion {
                case .finished:
                    ()
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { questions in
                print("✅ Questions received! \(questions.questions.count)")
            }).store(in: &cancellables)
    }

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
