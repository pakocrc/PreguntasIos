//
//  PlayersSetupViewModel.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 2/3/22.
//

import Combine
import Foundation

final class PlayersSetupViewModel: ObservableObject, Identifiable {
    @Published var players = [String]()
    @Published var dismissView = false

    init() {
        self.players = UserSettings().players.map({ $0.name })
    }

    func continueButtonPressed() {
        var userSettings = UserSettings()
        userSettings.players = self.players.map({ Player(name: $0) })
        dismissView = true
    }

    // MARK: - Helpers

    deinit {
        print("PlayersSetupViewModel deinit 🗑")
    }
}
