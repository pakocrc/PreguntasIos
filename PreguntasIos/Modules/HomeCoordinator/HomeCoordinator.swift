//
//  HomeCoordinator.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 4/3/22.
//

import Foundation

final class HomeCoordinator: ObservableObject {
    // MARK: - View Models
    @Published var settingsViewModel: SettingsViewModel?
    @Published var playersSetupViewModel: PlayersSetupViewModel?
    @Published var gameViewModel: GameViewModel?

    // MARK: - Data
    @Published private (set) var categories: [QuestionCategory]
    @Published private (set) var questions: [Question]
    @Published private (set) var setupPlayers: Bool

    init(categories: [QuestionCategory], questions: [Question]) {
        self.categories = categories
        self.questions = questions

        //     if setupPlayers logic in user defaults {
                self.setupPlayers = true
        //    }

        self.categories.append(QuestionCategory.mixed)
        self.categories.append(QuestionCategory.all)

        categories.forEach({ print("🟠 Category: \($0.rawValue)")})
        questions.forEach({ print("🟢: \($0.id). \($0.en)")})
    }

    // MARK: - ⚙️ Helpers
    func openSettingsView() {
        self.settingsViewModel = SettingsViewModel()
    }

    func openPlayersSetupView() {
        self.playersSetupViewModel = PlayersSetupViewModel()
    }

    func openGameView(category: QuestionCategory) {
        // TODO: get players from user defaults
        let players = [Player(name: "Pako"), Player(name: "Mali")]

        self.gameViewModel = GameViewModel(category: category, players: players)
    }

    deinit {
        print("HomeCoordinator deinit 🗑")
    }
}
