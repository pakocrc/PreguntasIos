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
        VStack {
            Text("\(viewModel.currentPlayer)")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()

            Spacer(minLength: 100)

            Text(getQuestionString(viewModel.currentQuestion))
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()

            HStack(alignment: .center, spacing: 0) {
                Button(action: viewModel.likeQuestionButtonPressed, label: {
                    if viewModel.likedQuestion {
                        Image(systemName: "heart.fill")
                    } else {
                        Image(systemName: "heart")
                    }
                }).padding()

                Button(action: viewModel.reportQuestionButtonPressed, label: {
                    Image(systemName: "hand.thumbsdown")
                }).padding()

                Button(action: viewModel.suggestQuestionButtonPressed, label: {
                    Image(systemName: "text.bubble")
                }).padding()
            }

            Spacer()

            Button(action: viewModel.nextButtonPressed, label: {
                Text(NSLocalizedString("game_view_next_button", comment: ""))
                    .font(Font.body)
                    .frame(width: UIScreen.main.bounds.width - 20, height: 50, alignment: .center)
            })
                .foregroundColor(Color.primary)
                .background(Color.orange)
                .padding()
                .frame(width: UIScreen.main.bounds.width - 20, height: 50, alignment: .center)
                .cornerRadius(10)
        }
    }

    func getQuestionString(_ randomQuestion: Question?) -> String {
        var questionString = ""
        let emptyQuestionString = NSLocalizedString("game_view_empty_question", comment: "")

        switch viewModel.preferedLanguage {
        case .en: questionString = randomQuestion?.en ?? emptyQuestionString
        case .es: questionString = randomQuestion?.es ?? emptyQuestionString
        case .de: questionString = randomQuestion?.de ?? emptyQuestionString
        case .fr: questionString = randomQuestion?.fr ?? emptyQuestionString
        case .pt: questionString = randomQuestion?.pt ?? emptyQuestionString
        }

        return questionString
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameView(viewModel: GameViewModel(category: .friends, questions:
                                                Questions(questions: [
                                                    Question(id: "1",
                                                             category: .friends,
                                                             es: """
                                                             ¿Cúal crees tu que es el significado
                                                             de la vida en esta tierra?
                                                             """,
                                                             en: "", pt: "", fr: "", de: "")
                                                ], categories: []),
                                              apiService: GameAPIClient(),
                                              parent: GameCoordinator(
                                                questions: Questions(questions: [], categories: []),
                                                category: .friends,
                                                gameAPIService: GameAPIClient())))

            GameView(viewModel: GameViewModel(category: .friends, questions:
                                                Questions(questions: [
                                                    Question(id: "1",
                                                             category: .friends,
                                                             es: """
                                                             ¿Cúal crees tu que es el significado
                                                             de la vida en esta tierra?
                                                             """,
                                                             en: "", pt: "", fr: "", de: "")
                                                ], categories: []),
                                              apiService: GameAPIClient(),
                                              parent: GameCoordinator(
                                                questions: Questions(questions: [], categories: []),
                                                category: .friends,
                                                gameAPIService: GameAPIClient())))
                .preferredColorScheme(.dark)
        }
    }
}
