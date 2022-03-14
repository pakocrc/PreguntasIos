//
//  GameViewModel.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 2/3/22.
//

import Combine
import Foundation

final class GameViewModel: ObservableObject {
    private let apiService: GameApiService

    @Published var category: QuestionCategory
    @Published var questions: [Question]
//    @Published var players: [Player] = UserSettings().players
    @Published var players: [Player] = [Player(name: "Pako"), Player(name: "Kilay")]

    @Published var preferedLanguage = UserSettings().preferedLanguage
    @Published var currentQuestion: Question?
    @Published var currentPlayer = ""
    @Published var likedQuestion = false

    private var currentPlayerIndex: Int = 0
    private var questionsAsked = [String]()
    private var cancellables = Set<AnyCancellable>()

    private unowned let parent: GameCoordinator

    init(category: QuestionCategory, questions: Questions, apiService: GameApiService, parent: GameCoordinator) {
        self.category = category
        self.apiService = apiService
        self.parent = parent

        switch category {
        case .friends, .life, .dirty:
            self.questions = questions.questions.filter({ $0.category == category })
        case .liked:
            self.questions = questions.questions.filter({ question in
                UserSettings().likedQuestions.contains(where: {
                    $0 == question.id
                })
            })
        case .mixed, .all:
            self.questions = questions.questions
        }

        self.nextQuestion()
        self.nextPlayer()
        self.gameStarted()
    }

    func nextButtonPressed() {
        nextQuestion()
        nextPlayer()
    }

    func likeQuestionButtonPressed() {
        var userSettings = UserSettings()

        likedQuestion.toggle()

        if let currentQuestion = currentQuestion {
            userSettings.likedQuestions.append(currentQuestion.id)
        }
    }

    func reportQuestionButtonPressed() {
        print("reportQuestionButtonPressed")
    }

    func suggestQuestionButtonPressed() {
        parent.suggestQuestionView()
    }

    // MARK: - Helpers
    private func nextQuestion() {
        currentQuestion = questions.randomElement()
        questionsLiked()
    }

    private func questionsLiked() {
        let userSettings = UserSettings()
        likedQuestion = userSettings.likedQuestions.contains(where: { $0 == currentQuestion?.id })
    }

    private func nextPlayer() {
        currentPlayerIndex =
            (currentPlayer == "" || currentPlayerIndex + 1 < players.count) ? currentPlayerIndex + 1 : 0

        currentPlayer = players[currentPlayerIndex].name
    }

    private func gameStarted() {
        self.apiService.gameStarted(players: UserSettings().players, language: UserSettings().preferedLanguage)
            .sink(receiveCompletion: { completion in

                switch completion {
                case .failure(let error):
                    print("🔴 Unable to start game. Error: \(error)")
                default: break
                }
            }, receiveValue: { result in
                print("🟠 Game started. \(result)")
            }).store(in: &cancellables)
    }

    deinit {
        print("GameViewModel deinit 🗑")
    }
}
