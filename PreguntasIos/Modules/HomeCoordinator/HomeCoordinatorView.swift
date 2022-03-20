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
                        CustomRowView(buttonTitle: "category_\(category.rawValue.lowercased())".localized())
//                        VStack {
//                            Text("category_\(category.rawValue.lowercased())".localized())
//                                .font(Font.title)
//                                .fontWeight(.bold)
//                                .foregroundColor(Color.primary)
//                                .frame(alignment: .topLeading)
//
//                            Text("Questions about this and that")
//                                .font(Font.body)
//                                .fontWeight(.regular)
//                                .foregroundColor(Color.primary)
//                                .frame(alignment: .leading)
//                        }
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

struct CustomRowView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var buttonTitle: String

    var body: some View {
        VStack {
            Text(buttonTitle)
                .font(.title)
                .fontWeight(.regular)
                .foregroundColor(.primary)
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(.leading, 10)
        .padding(.vertical, 40)
        .background(Color.secondary)
        .cornerRadius(12)
        .shadow(color: colorScheme == .light ? Color.primary : .clear,
                radius: colorScheme == .light ? 5.0 : 0.0,
                x: 1.0,
                y: 1.0)
    }
}

struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeCoordinatorView(coordinator:
                                    HomeCoordinator(questions:
                                                        Questions(questions: [], categories: [
                                                            .friends, .life, .dirty, .dirty, .all
                                                        ])))
            HomeCoordinatorView(coordinator:
                                    HomeCoordinator(questions:
                                                        Questions(questions: [], categories: [
                                                            .friends, .life, .dirty, .dirty, .all
                                                        ])))
                .preferredColorScheme(.dark)
        }
    }
}
