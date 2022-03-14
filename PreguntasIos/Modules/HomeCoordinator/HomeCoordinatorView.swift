//
//  HomeCoordinatorView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 4/3/22.
//

import SwiftUI

struct HomeCoordinatorView: View {
    @ObservedObject var coordinator: HomeCoordinator
    @State private var questionCategory: QuestionCategory = .friends

    var body: some View {
        NavigationView {
            List {
                ForEach(coordinator.questions.categories, id: \.self) { category in
                    if coordinator.setupPlayers {
                        Button(action: {
                            coordinator.openPlayersSetupView()
                            questionCategory = category
                        }, label: {
                            Text(NSLocalizedString("category_\(category.rawValue.lowercased())", comment: ""))
                                .font(Font.body)
                                .foregroundColor(Color.primary)
                        })

                    } else {
                        Button(action: {
                            coordinator.openGameCoordinator(category: category)
                            questionCategory = category
                        }, label: {
                            Text(NSLocalizedString("category_\(category.rawValue.lowercased())", comment: ""))
                                .font(Font.body)
                                .foregroundColor(Color.primary)
                        })
                    }
                }
            }
            .toolbar {
                Button(action: coordinator.openSettingsView, label: {
                    Image(systemName: "gear")
                }).sheet(item: $coordinator.settingsViewModel) { SettingsView(viewModel: $0) }
            }
            .navigation(item: $coordinator.gameCoordinator) { gameCoordinator in
                GameCoordinatorView(coordinator: gameCoordinator)
            }
            .sheet(item: $coordinator.playersSetupViewModel) {
                if !UserSettings().players.isEmpty {
                    coordinator.playerSetupChanged(category: questionCategory)
                }
            } content: { viewModel in
                PlayersSetupView(viewModel: viewModel)
            }
            .alert(NSLocalizedString("alert", comment: "Alert"),
                   isPresented: $coordinator.showErrorMessage, actions: {}, message: {
                Text(coordinator.errorMessage ?? "")
            })
        }
    }
}

struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCoordinatorView(coordinator:
                                HomeCoordinator(questions:
                                                    Questions(questions: [], categories: [
                                                        .friends, .life, .dirty, .dirty, .all
                                                    ])))
    }
}
