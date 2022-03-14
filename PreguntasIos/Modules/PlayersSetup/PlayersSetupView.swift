//
//  PlayersSetupView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 2/3/22.
//

import Combine
import SwiftUI

struct PlayersSetupView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var viewModel: PlayersSetupViewModel

    @State var playerOne = ""
    @State var playerTwo = ""

    var body: some View {
        VStack {
            Text("players_setup_header".localized())
                .font(.largeTitle)
                .padding()

            Text("players_setup_subheader".localized())
                .font(.body)

            List {
                //                    ForEach(viewModel.players, id: \.name) { player in
                TextField(text: $playerOne,
                          prompt: Text("Add \(viewModel.players.first?.name ?? "") name".capitalized)) {
                    Text(viewModel.players.first?.name ?? "")
                }.onChange(of: playerOne) { newValue in
                    if let player1 = viewModel.players.first {
                        viewModel.setPlayerName(player: player1, newValue: newValue)
                    }
                }

                TextField(text: $playerTwo, prompt:
                            Text("Add \(viewModel.players.last?.name ?? "") name".capitalized)) {
                    Text(viewModel.players.last?.name ?? "")
                }.onChange(of: playerTwo) { newValue in
                    if let player2 = viewModel.players.last {
                        viewModel.setPlayerName(player: player2, newValue: newValue)
                    }
                }
                //                    .onDelete { indexSet in
                //                        if viewModel.players.count > 1 {
                //                            playersCount -= 1
                //                            viewModel.removePlayer(at: indexSet)
                //                        }
                //                    }
            }

            Button(action: viewModel.continueButtonPressed, label: {
                Text("players_setup_done_button")
                    .font(Font.body)
                    .frame(width: UIScreen.main.bounds.width - 20, height: 50, alignment: .center)
            })
                .disabled(!viewModel.validPlayers())
                .foregroundColor(!viewModel.validPlayers() ?
                                 Color.white : Color.primary)
                .background(!viewModel.validPlayers() ?
                            Color.gray : Color.orange)
                .padding()
                .frame(width: UIScreen.main.bounds.width - 20, height: 50, alignment: .center)
                .cornerRadius(10)
        }
        .onChange(of: viewModel.dismissView) { _ in
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct PlayersSetupView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersSetupView(viewModel: PlayersSetupViewModel())
    }
}
