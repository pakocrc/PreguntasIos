//
//  HomeCoordinator.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 4/3/22.
//

import Foundation

final class HomeCoordinator: ObservableObject {
    // MARK: - View Models
    @Published var playersSetupViewModel: PlayersSetupViewModel?

    @Published var gameCoordinator: GameCoordinator?
    @Published var settingsCoordinator: SettingsCoordinator?

    // MARK: Error
    @Published private (set) var errorMessage: String?
    @Published var showErrorMessage = false

    // MARK: - Data
    @Published private (set) var questions: Questions
    @Published private (set) var setupPlayers: Bool

    private let gameAPIService = GameAPIClient()

    init(questions: Questions) {
        self.questions = questions
        self.setupPlayers = UserSettings().players.isEmpty
    }

    // MARK: - ⚙️ Helpers
    func openSettingsCoordinator() {
        self.settingsCoordinator = SettingsCoordinator()
    }

    func openPlayersSetupView() {
        self.playersSetupViewModel = PlayersSetupViewModel()
    }

    func openGameCoordinator(category: QuestionCategory) {
        self.gameCoordinator = GameCoordinator(questions: questions, category: category, gameAPIService: gameAPIService)
    }

    func playerSetupChanged(category: QuestionCategory) {
        self.setupPlayers = false
        self.gameCoordinator = GameCoordinator(questions: questions, category: category, gameAPIService: gameAPIService)
    }

    deinit {
        print("HomeCoordinator deinit 🗑")
    }
}
