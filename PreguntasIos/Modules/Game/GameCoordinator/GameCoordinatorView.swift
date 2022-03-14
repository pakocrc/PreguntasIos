//
//  GameCoordinatorView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 13/3/22.
//

import SwiftUI

struct GameCoordinatorView: View {
    @ObservedObject var coordinator: GameCoordinator

    var body: some View {
        currentGameView()
            .sheet(item: $coordinator.suggestQuestionViewModel) { viewModel in
                SuggestQuestionView(viewModel: viewModel)
            }
            .sheet(item: $coordinator.questionFeedbackViewModel) { viewModel in
                QuestionFeedbackView(viewModel: viewModel)
            }
            .alert("alert".localized(),
                   isPresented: $coordinator.showErrorMessage,
                   actions: { },
                   message: { Text(coordinator.errorMessage ?? "") })
    }

    @ViewBuilder
    private func currentGameView() -> some View {
        if coordinator.gameViewModel != nil {
            GameView(viewModel: coordinator.gameViewModel!)

        } else if coordinator.allQuestionsViewModel != nil {
            AllQuestionsView(viewModel: coordinator.allQuestionsViewModel!)

        } else {
            EmptyView()
        }
    }
}

struct GameCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        GameCoordinatorView(coordinator: GameCoordinator(
            questions: Questions(questions: [], categories: []),
            category: .friends,
            gameAPIService: GameAPIClient()))
    }
}
