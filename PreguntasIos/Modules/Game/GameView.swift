//
//  GameView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 2/3/22.
//

import Lottie
import SwiftUI

struct GameView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: GameViewModel

    private let animation = LottieView(name: "question-mark-animation", loopMode: .playOnce)
    @State private var isAnimating = false

    var body: some View {
        ZStack(alignment: .center) {
            animation
                .frame(maxWidth: 300, maxHeight: 300, alignment: .center)
                .background(isAnimating ? (colorScheme == .light ? .gray : .white) : .clear)
                .cornerRadius(150)
                .onTapGesture(count: 2) {
                    animation.animationView.stop()
                    isAnimating = false
                }

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

                if !(viewModel.currentQuestion?.author?.isEmpty ?? true) {
                    Text("\("game_view_by".localized()) \(viewModel.currentQuestion?.author ?? "")")
                        .font(.body)
                        .fontWeight(.light)
                        .padding()
                }

                Spacer()

                HStack(alignment: .center, spacing: 0) {
                    Button(action: viewModel.likeQuestionButtonPressed, label: {
                        if viewModel.likedQuestion {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: "heart")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(.primary)
                        }
                    }).padding()

                    Button(action: viewModel.questionFeedbackButtonPressed, label: {
                        Image(systemName: "hand.thumbsdown")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(.primary)
                    }).padding()

                    Button(action: viewModel.suggestQuestionButtonPressed, label: {
                        Image(systemName: "text.bubble")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(.primary)
                    }).padding()
                }

                Spacer()

                Button(action: {
                    handleAnimation()
                    viewModel.nextButtonPressed()

                }, label: {
                    Text("game_view_next_button".localized())
                        .font(.body)
                        .fontWeight(.semibold)
                        .frame(width: UIScreen.main.bounds.width - 20, height: 50, alignment: .center)
                })
                    .foregroundColor(Color.primary)
                    .background(Color.orange)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 20, height: 50, alignment: .center)
                    .cornerRadius(10)
            }
            .onChange(of: viewModel.currentQuestion, perform: { _ in
                handleAnimation()
            })
            .opacity(isAnimating ? 0.0 : 1.0)
        }
    }

    private func handleAnimation() {
        if isAnimating {
            isAnimating = false
            animation.animationView.stop()
        } else {
            isAnimating = true
            animation.animationView.play()
        }
    }

    private func getQuestionString(_ randomQuestion: Question?) -> String {
        var questionString = ""
        let emptyQuestionString = "game_view_empty_question".localized()

        switch viewModel.preferedLanguage {
        case .en: questionString = randomQuestion?.en ?? emptyQuestionString
        case .es: questionString = randomQuestion?.es ?? emptyQuestionString
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
                                                             en: "", pt: "", fr: "", de: "", author: "Anonymous")
                                                ], categories: []),
                                              apiService: GameApiClient(),
                                              parent: GameCoordinator(
                                                questions: Questions(questions: [], categories: []),
                                                category: .friends,
                                                gameAPIService: GameApiClient())))

            GameView(viewModel: GameViewModel(category: .friends, questions:
                                                Questions(questions: [
                                                    Question(id: "1",
                                                             category: .friends,
                                                             es: """
                                                             ¿Cúal crees tu que es el significado
                                                             de la vida en esta tierra?
                                                             """,
                                                             en: "", pt: "", fr: "", de: "", author: "Pako 🇨🇷")
                                                ], categories: []),
                                              apiService: GameApiClient(),
                                              parent: GameCoordinator(
                                                questions: Questions(questions: [], categories: []),
                                                category: .friends,
                                                gameAPIService: GameApiClient())))
                .preferredColorScheme(.dark)
        }
    }
}
