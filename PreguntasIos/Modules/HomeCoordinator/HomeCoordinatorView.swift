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
            ScrollView {
                ForEach(coordinator.questions.categories, id: \.self) { category in
                    Button(action: {
                        questionCategory = category

                        if coordinator.setupPlayers {
                            coordinator.openPlayersSetupView()

                        } else {
                            coordinator.openGameCoordinator(category: category)
                        }

                    }, label: {
                        CategoryRowView(buttonTitle: "category_\(category.rawValue.lowercased())".localized())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                    })
                }
            }
            .navigationTitle(Text("app_name".localized()))
            .toolbar {
                Button(action: coordinator.openSettingsCoordinator, label: {
                    Image(systemName: "gear")
                        .foregroundColor(.primary)
                }).sheet(item: $coordinator.settingsCoordinator) { SettingsCoordinatorView(coordinator: $0) }
            }
            .navigation(item: $coordinator.gameCoordinator) { gameCoordinator in
                GameCoordinatorView(coordinator: gameCoordinator)
            }
            .sheet(item: $coordinator.playersSetupViewModel) {
                if !UserSettings().players.isEmpty {
                    coordinator.playerSetupChanged(category: questionCategory)
                }
            } content: { viewModel in
                NavigationView {
                    PlayersSetupView(viewModel: viewModel)
                }
            }
            .alert("alert".localized(),
                   isPresented: $coordinator.showErrorMessage, actions: {}, message: {
                Text(coordinator.errorMessage ?? "")
            })
        }
    }
}

struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeCoordinatorView(coordinator:
                                    HomeCoordinator(questions:
                                                        Questions(questions: [], categories: [
                                                            .friends, .life, .dirty, .mixed, .all
                                                        ])))
            HomeCoordinatorView(coordinator:
                                    HomeCoordinator(questions:
                                                        Questions(questions: [], categories: [
                                                            .friends, .life, .dirty, .mixed, .all
                                                        ])))
                .preferredColorScheme(.dark)
        }
    }
}
