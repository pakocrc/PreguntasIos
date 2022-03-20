//
//  SuggestQuestionView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 13/3/22.
//

import SwiftUI

struct SuggestQuestionView: View {

    private enum Field: Int, CaseIterable {
        case question, user
    }

    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var viewModel: SuggestQuestionViewModel

    @State private var question = ""
    @State private var user = ""
    @State private var flagSelected = "🇨🇷 Costa Rica"
    @FocusState private var focusedField: Field?

    var body: some View {
        NavigationView {
            ZStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .opacity(viewModel.loading ? 1.0 : 0.0)
                    .font(.largeTitle)
                    .padding()

                VStack {
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("suggest_question_view_type_question".localized())
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding(.leading)

                            TextFieldEditor(textValue: $question)
                                .focused($focusedField, equals: .question)

                            Text("suggest_question_view_name".localized())
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding([.leading, .top])

                            TextFieldEditor(textValue: $user)
                                .focused($focusedField, equals: .user)

                            Text("suggest_question_view_flag_optional".localized())
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding(.leading)
                            Picker("", selection: $flagSelected) {
                                ForEach(flagList, id: \.self) { flag in
                                    Text(flag)
                                        .foregroundColor(Color.primary)
                                        .font(.body)
                                        .fontWeight(.bold)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .padding(.horizontal)
                        }
                        .padding()
                    }

                    Spacer()

                    Button(action: {
                        if !question.isEmpty {
                            viewModel.sendButtonPressed(question: question, user: user, flag: flagSelected)
                        }
                        self.focusedField = nil
                    }, label: {
                        Text("suggest_question_view_next_button".localized())
                            .font(Font.body)
                            .frame(width: UIScreen.main.bounds.width - 20, height: 50, alignment: .center)
                    })
                        .disabled(question.isEmpty || viewModel.loading)
                        .foregroundColor(Color.primary)
                        .background(question.isEmpty || viewModel.loading ? Color.gray : Color.orange)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 20, height: 50, alignment: .center)
                        .cornerRadius(10)
                }
            }
            .alert("alert".localized(),
                   isPresented: $viewModel.showErrorMessage,
                   actions: { },
                   message: { Text(viewModel.alertMessage ?? "") })
            .alert("alert".localized(),
                   isPresented: $viewModel.showAlertMessage,
                   actions: {
                Button("ok".localized(), action: {
                    viewModel.dismissViewAction()
                })
            }, message: { Text(viewModel.alertMessage ?? "") })
            .navigationTitle("suggest_question_view_title".localized())
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    })
                }
            })
            .onChange(of: viewModel.dismissView) { _ in
                presentationMode.wrappedValue.dismiss()
            }
            .onTapGesture {
                focusedField = nil
            }
        }
    }
}

struct SuggestQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SuggestQuestionView(viewModel:
                                    SuggestQuestionViewModel(
                                        gameAPIService: GameApiClient()))
            SuggestQuestionView(viewModel: SuggestQuestionViewModel(
                gameAPIService: GameApiClient()))
                .preferredColorScheme(.dark)
        }
    }
}
