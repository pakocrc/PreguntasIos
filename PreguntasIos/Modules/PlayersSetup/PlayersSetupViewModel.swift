//
//  PlayersSetupViewModel.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 2/3/22.
//

import Combine
import Foundation

final class PlayersSetupViewModel: ObservableObject, Identifiable {
    @Published var players = [Player]()
    @Published var dismissView = false

    init() {
        addPlayer(player: Player(name: ""))
        addPlayer(player: Player(name: ""))
    }

    func setPlayerName(player: Player, newValue: String) {
        if let indexPath = players.firstIndex(where: { $0.id == player.id }) {
            players[indexPath].name = newValue
        }
    }

    func removePlayer(at indexSet: IndexSet) {
        players.remove(atOffsets: indexSet)
    }

//    func addPlayerDefaultPlayer() {
//        var playerName = getPlayerName()
//
//        if players.contains(where: { $0.name == playerName }) {
//            playerName = getUnorderedPlayerName()
//        }
//
//        addPlayer(player: Player(name: playerName))
//    }
//
    func addPlayer(player: Player) {
        players.append(player)
    }

    func continueButtonPressed() {
        var userSettings = UserSettings()
        userSettings.players = self.players
        dismissView = true
    }

    func validPlayers() -> Bool {
        return players.allSatisfy({ !$0.name.isEmpty })
    }

    // MARK: - Helpers
//    private func getPlayerName() -> String {
//        let playerPlaceholder = NSLocalizedString("players_setup_new_player_placeholder", comment: "")
//        return String(format: playerPlaceholder, players.count.description)
//    }
//
//    private func getUnorderedPlayerName() -> String {
//        let playerPlaceholder = NSLocalizedString("players_setup_new_player_placeholder", comment: "")
//        return String(format: playerPlaceholder,
//                      Int.random(in: ClosedRange(uncheckedBounds: (players.count, 100))).description)
//    }

    deinit {
        print("PlayersSetupViewModel deinit 🗑")
    }
}
