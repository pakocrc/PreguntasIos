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

    var body: some View {
        VStack {
            Form {
                ListEditor(title: "players_setup_players".localized(),
                           placeholderText: "players_setup_player_placeholder".localized(),
                           addText: "players_setup_add_player".localized(),
                           list: $viewModel.players)
            }

            Button(action: viewModel.continueButtonPressed, label: {
                Text("players_setup_done_button")
                    .font(Font.body)
                    .frame(width: UIScreen.main.bounds.width - 20, height: 50, alignment: .center)
            })
                .disabled(validateForm())
                .foregroundColor(validateForm() ? Color.white : Color.primary)
                .background(validateForm() ? Color.gray : Color.orange)
                .padding()
                .frame(width: UIScreen.main.bounds.width - 20, height: 50, alignment: .center)
                .cornerRadius(10)
        }
        .navigationTitle(Text("players_setup_header".localized()))
        .onChange(of: viewModel.dismissView) { _ in
            presentationMode.wrappedValue.dismiss()
        }
    }

    private func validateForm() -> Bool {
        return viewModel.players.isEmpty || viewModel.players.contains(where: { $0.isEmpty})
    }

    private struct ListEditor: View {
        var title: String
        var placeholderText: String
        var addText: String
        @Binding var list: [String]

        func getBinding(forIndex index: Int) -> Binding<String> {
            return Binding<String>(
                get: { list[index] },
                set: {
                    if index < list.count {
                        list[index] = $0
                    } else {
                        list[index - 1] = $0
                    }
                }
            )
        }

        var body: some View {
            Section(header: Text(title)) {
                ForEach(0..<list.count, id: \.self) { index in
                    ListItem(placeholder: placeholderText, text: getBinding(forIndex: index)) {
                        self.list.remove(at: index)
                    }
                }
                AddButton(text: addText) { self.list.append("") }
            }
        }
    }

    private struct ListItem: View {
        var placeholder: String
        @Binding var text: String
        var removeAction: () -> Void

        var body: some View {
            HStack {
                Button(action: removeAction) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }
                TextField(placeholder, text: $text)
            }
        }

    }

    private struct AddButton: View {
        var text: String
        var addAction: () -> Void

        var body: some View {
            Button(action: addAction) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                        .padding(.horizontal)
                    Text(text)
                }
            }
        }
    }
}

struct PlayersSetupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlayersSetupView(viewModel: PlayersSetupViewModel())

            PlayersSetupView(viewModel: PlayersSetupViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
