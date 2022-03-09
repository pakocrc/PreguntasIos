//
//  GameView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 2/3/22.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
//        NavigationLink(destination: <#T##() -> _#>, label: <#T##() -> _#>)
        Text("Game view...")

    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(category: QuestionCategory.friends, players: []))
    }
}
