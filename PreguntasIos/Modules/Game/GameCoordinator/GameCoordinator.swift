//
//  GameCoordinator.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 13/3/22.
//

import Foundation

final class GameCoordinator: ObservableObject {

    // MARK: View Models
    @Published var gameViewModel: GameViewModel?
    @Published var allQuestionsViewModel: AllQuestionsViewModel?
    @Published var suggestQuestionViewModel: SuggestQuestionViewModel?
    @Published var questionFeedbackViewModel: QuestionFeedbackViewModel?

    // MARK: Error
    @Published private (set) var errorMessage: String?
    @Published var showErrorMessage = false

    @Published private (set) var questions: Questions

    private let gameAPIService: GameApiService
    private let category: QuestionCategory

    init(questions: Questions, category: QuestionCategory, gameAPIService: GameApiService) {
        self.questions = questions
        self.gameAPIService = gameAPIService
        self.category = category

        switch category {
        case .friends, .life, .dirty, .mixed:
            self.gameViewModel = GameViewModel(category: category,
                                               questions: questions,
                                               apiService: gameAPIService,
                                               parent: self)
        case .all:
            self.allQuestionsViewModel = AllQuestionsViewModel(questions: questions)

        case .liked:
            if UserSettings().likedQuestions.isEmpty {
                self.errorMessage = "home_coordinator_no_liked_questions_error_message".localized()
                self.showErrorMessage = true
            } else {
                self.gameViewModel = GameViewModel(category: category,
                                                   questions: questions,
                                                   apiService: gameAPIService,
                                                   parent: self)
            }
        }
    }

    func suggestQuestionView() {
        self.suggestQuestionViewModel = SuggestQuestionViewModel(gameAPIService: gameAPIService)
    }

    func questionFeedbackView(question: Question) {
        self.questionFeedbackViewModel = QuestionFeedbackViewModel(gameAPIService: gameAPIService, question: question)
    }
}
