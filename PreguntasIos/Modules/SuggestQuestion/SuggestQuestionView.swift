//
//  SuggestQuestionView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 13/3/22.
//

import SwiftUI

struct SuggestQuestionView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme

    @ObservedObject var viewModel: SuggestQuestionViewModel

    @State var question = ""
    @State var user = ""

    var body: some View {
        NavigationView {
            ZStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .opacity(viewModel.loading ? 1.0 : 0.0)
                    .font(.largeTitle)
                    .padding()

                VStack(alignment: .leading) {
                    TextField(text: $question, prompt: Text(
                        NSLocalizedString("suggest_question_view_type_question_placeholder",
                                          comment: ""))) { }
                    .multilineTextAlignment(.leading)
                    .frame(height: 45, alignment: .topLeading)
                    .padding(.all)
                    .foregroundColor(
                        colorScheme == .light ?
                        Color.secondary :
                        Color.primary
                    )
                    .background(
                        colorScheme == .light ?
                            Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0) :
                            Color.secondary
                    )
                    .cornerRadius(5)
                    .padding(.bottom, 30)
                    .onChange(of: question) { newValue in
                        viewModel.setQuestion(question: newValue)
                    }

                    HStack {
                        Text(NSLocalizedString("suggest_question_view_name_flag", comment: ""))
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text(NSLocalizedString("suggest_question_view_name_flag_optional", comment: ""))
                            .font(.caption)
                            .fontWeight(.regular)
                    }.padding(.leading)

                    TextField(text: $user,
                              prompt: Text(
                                NSLocalizedString("suggest_question_view_type_name_flag_placeholder",
                                                  comment: ""))) { }
                    .multilineTextAlignment(.leading)
                    .frame(height: 30, alignment: .topLeading)
                    .padding(.all)
                    .foregroundColor(
                        colorScheme == .light ?
                            Color.secondary :
                            Color.primary
                    )
                    .background(
                        colorScheme == .light ?
                            Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0) :
                            Color.secondary
                    )
                    .cornerRadius(5)
                    .onChange(of: question) { newValue in
                        viewModel.setUser(user: newValue)
                    }

                    Spacer()

                    Button(action: {
                        viewModel.sendButtonPressed(question: question, user: user)
                    }, label: {
                        Text(NSLocalizedString("suggest_question_view_next_button", comment: ""))
                            .font(Font.body)
                            .frame(width: UIScreen.main.bounds.width - 20, height: 50, alignment: .center)
                    })
                        .disabled(question.isEmpty)
                        .foregroundColor(Color.primary)
                        .background(question.isEmpty ? Color.gray : Color.orange)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 20, height: 50, alignment: .center)
                        .cornerRadius(10)
                }
                .padding()
            }
            .alert(NSLocalizedString("alert", comment: "Alert"),
                   isPresented: $viewModel.showErrorMessage,
                   actions: { },
                   message: { Text(viewModel.errorMessage ?? "") })
            .navigationTitle(NSLocalizedString("suggest_question_view_title", comment: ""))
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
}

struct SuggestQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SuggestQuestionView(viewModel: SuggestQuestionViewModel(gameAPIService: GameAPIClient()))

            SuggestQuestionView(viewModel: SuggestQuestionViewModel(gameAPIService: GameAPIClient()))
                    .preferredColorScheme(.dark)
        }
    }
}
