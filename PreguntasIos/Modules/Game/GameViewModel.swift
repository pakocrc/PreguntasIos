//
//  GameViewModel.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 2/3/22.
//

import Foundation

final class GameViewModel: ObservableObject {
    @Published var category: QuestionCategory
    @Published var players: [Player]

    @Published var aux: Bool = false

    init(category: QuestionCategory, players: [Player]) {
        self.category = category
        self.players = players
    }

    deinit {
        print("GameViewModel deinit 🗑")
    }
}
