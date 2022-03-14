//
//  QuestionFeedbackView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 13/3/22.
//

import SwiftUI

enum AvocadoStyle {
    case sliced, mashed
}

struct Order {
    var avocadoStyle: AvocadoStyle
}

struct QuestionFeedbackView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme

    @ObservedObject var viewModel: QuestionFeedbackViewModel

    @State var feedback = ""
    @State var feedbackType: FeedbackType?

    @State var order: Order = Order(avocadoStyle: .mashed)

    var textFieldLightColor = Color(
        red: 239.0/255.0,
        green: 243.0/255.0,
        blue: 244.0/255.0,
        opacity: 1.0)

    var body: some View {
        NavigationView {
            ZStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .opacity(viewModel.loading ? 1.0 : 0.0)
                    .font(.largeTitle)
                    .padding()

                VStack {
                    Text(NSLocalizedString("question_feedback_view_header", comment: ""))
                        .foregroundColor(Color.secondary)
                        .font(.body)

                    VStack {
                        ForEach(FeedbackType.allCases, id: \.self) { type in
                            HStack {
                                Button(action: {
                                    feedbackType = type
                                }, label: {
                                    Image(systemName: type == feedbackType ? "circle.fill" : "circle")
                                        .foregroundColor(Color.primary)

                                    Text(getFeedbackTypeText(type))
                                        .font(Font.body)
                                        .frame(height: 35, alignment: .leading)
                                        .foregroundColor(Color.primary)
                                })

                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal)

//                    if feedbackType == .other {
                    TextField(text: $feedback, prompt: Text(
                        NSLocalizedString("question_feedback_view_text_field_placeholder",
                                          comment: ""))) { }
                                          .multilineTextAlignment(.leading)
                                          .frame(height: 45, alignment: .topLeading)
                                          .padding(.all)
                                          .foregroundColor(colorScheme == .light ? Color.secondary : Color.primary)
                                          .background(colorScheme == .light ? textFieldLightColor : Color.secondary)
                                          .cornerRadius(5)
                                          .padding(.bottom, 30)
//                    }

                    Spacer()

                    Button(action: {
                        viewModel.sendButtonPressed(feedbackType: feedbackType, feedback: feedback)
                    }, label: {
                        Text(NSLocalizedString("question_feedback_view_next_button", comment: ""))
                            .font(Font.body)
                            .frame(width: UIScreen.main.bounds.width - 20, height: 50, alignment: .center)
                    })
                        .disabled(feedbackType == nil || viewModel.loading)
                        .foregroundColor(Color.primary)
                        .background(feedbackType == nil || viewModel.loading ? Color.gray : Color.orange)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 20, height: 50, alignment: .center)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle(NSLocalizedString("question_feedback_view_title", comment: ""))
            .alert(NSLocalizedString("alert", comment: "Alert"),
                   isPresented: $viewModel.showErrorMessage,
                   actions: { },
                   message: { Text(viewModel.alertMessage ?? "") })
            .alert(NSLocalizedString("alert", comment: "Alert"),
                   isPresented: $viewModel.showAlertMessage,
                   actions: {
                Button(NSLocalizedString("ok", comment: ""), action: {
                    viewModel.dismissViewAction()
                })
            }, message: { Text(viewModel.alertMessage ?? "") })
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: { Image(systemName: "xmark") })
                }
            })
            .onChange(of: viewModel.dismissView) { _ in
                presentationMode.wrappedValue.dismiss()
            }
        }
    }

    private func getFeedbackTypeText(_ feedbackType: FeedbackType) -> String {
        var feedbackTypeString = ""

        switch feedbackType {
        case .badTranslation:
            feedbackTypeString = NSLocalizedString("question_feedback_view_feedback_type_bad_translation", comment: "")
        case .inappropiateOrOffensive:
            feedbackTypeString =
            NSLocalizedString("question_feedback_view_feedback_type_inappropiate_or_offensive", comment: "")
        case .moodKiller:
            feedbackTypeString = NSLocalizedString("question_feedback_view_feedback_type_mood_killer", comment: "")
        case .other:
            feedbackTypeString = NSLocalizedString("question_feedback_view_feedback_type_other", comment: "")
        }

        return feedbackTypeString
    }
}

struct QuestionFeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        let question = Question(id: "1", category: .friends, es: "", en: "", pt: "", fr: "", de: "")
        Group {
            QuestionFeedbackView(viewModel:
                                    QuestionFeedbackViewModel(gameAPIService: GameAPIClient(),
                                                                      question: question))

            QuestionFeedbackView(viewModel:
                                    QuestionFeedbackViewModel(gameAPIService: GameAPIClient(),
                                                                      question: question))
                .preferredColorScheme(.dark)
        }
    }
}
