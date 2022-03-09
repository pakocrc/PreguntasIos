//
//  HomeCoordinatorView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 4/3/22.
//

import SwiftUI

struct HomeCoordinatorView: View {
    @ObservedObject var coordinator: HomeCoordinator

    var body: some View {
        NavigationView {
            List {
                ForEach(coordinator.categories, id: \.self) { category in
                    if coordinator.setupPlayers {
                        Button(action: coordinator.openPlayersSetupView, label: {
                            Text(NSLocalizedString("category_\(category.rawValue.lowercased())", comment: ""))
                                .font(Font.body)
                                .foregroundColor(Color.primary)
                        })
                            .sheet(item: $coordinator.playersSetupViewModel) {
                                // TODO: Verify if players are ok and navigate to game view
                                print("TODO: Verify if players are ok and navigate to game view")
                            } content: { viewModel in
                                PlayersSetupView(viewModel: viewModel)
                            }
                    } else {
                        Button(action: {
                            coordinator.openGameView(category: category)
                        }, label: {
                            Text(NSLocalizedString("category_\(category.rawValue.lowercased())", comment: ""))
                                .font(Font.body)
                                .foregroundColor(Color.primary)
                                .navigation(item: $coordinator.gameViewModel) { viewModel in
                                    GameView(viewModel: viewModel)
                                }
                        })
                    }
                }
            }
            .navigationTitle(NSLocalizedString("app_name", comment: ""))
            .toolbar {
                Button(action: coordinator.openSettingsView, label: {
                    Image(systemName: "gear")
                }).sheet(item: $coordinator.settingsViewModel) { SettingsView(viewModel: $0) }
            }
        }
    }
}

struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCoordinatorView(coordinator: HomeCoordinator(categories: [], questions: []))
    }
}
