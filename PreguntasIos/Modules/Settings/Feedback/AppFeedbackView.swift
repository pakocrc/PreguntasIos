//
//  AppFeedbackView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 19/3/22.
//

import SwiftUI

struct AppFeedbackView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var viewModel: AppFeedbackViewModel
    @State private var feedback = ""
    @FocusState private var focusedField: Bool?

    @State private var appExperienceTypeSelected = AppExperienceType.regular

    var body: some View {
        ZStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(viewModel.loading ? 1.0 : 0.0)
                .font(.largeTitle)
                .padding()

            VStack(alignment: .leading) {
                Text("app_feedback_view_app_experience".localized())
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding([.leading, .top])
                Picker("", selection: $appExperienceTypeSelected) {
                    ForEach(AppExperienceType.allCases, id: \.self) { type in
                        Text(getAppExperienceText(type))
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()

                Text("app_feedback_view_text_field".localized())
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding([.leading, .top])
                TextFieldEditor(textValue: $feedback)
                    .focused($focusedField, equals: true)

                Spacer()

                Button(action: {
                    focusedField = nil
                    viewModel.sendButtonPressed(feedback: feedback,
                                                appExperienceType: appExperienceTypeSelected)
                }, label: {
                    Text("app_feedback_view_next_button".localized())
                        .font(Font.body)
                        .frame(width: UIScreen.main.bounds.width - 20, height: 50, alignment: .center)
                })
                    .disabled(feedback.isEmpty || viewModel.loading)
                    .foregroundColor(Color.primary)
                    .background(feedback.isEmpty || viewModel.loading ? Color.gray : Color.orange)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 20, height: 50, alignment: .center)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("app_feedback_view_title".localized())
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
        .onChange(of: viewModel.dismissView) { _ in
            presentationMode.wrappedValue.dismiss()
        }
        .onTapGesture {
            focusedField = nil
        }
    }

    private func getAppExperienceText(_ appExperienceType: AppExperienceType) -> String {
        var result = ""
        switch appExperienceType {
        case .bad:
            result = "🙁"
        case .regular:
            result = "😐"
        case .good:
            result = "😊"
        }
        return result
    }
}

struct AppFeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppFeedbackView(
                viewModel: AppFeedbackViewModel(
                    gameAPIService: GameApiClient()))
            AppFeedbackView(
                viewModel: AppFeedbackViewModel(
                    gameAPIService: GameApiClient()))
                .preferredColorScheme(.dark)
        }
    }
}
