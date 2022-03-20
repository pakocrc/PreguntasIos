//
//  AllQuestionsView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 13/3/22.
//

import SwiftUI

struct AllQuestionsView: View {
    @ObservedObject var viewModel: AllQuestionsViewModel

    @State private var selection: String?

    var body: some View {
        List(viewModel.questions.questions, selection: $selection) { question in
            Button(action: {
                self.selection = question.id
            }, label: {
                Text("\(question.id)) \(getQuestionString(question))")
                    .font(selection == question.id ? .headline : .body)
                    .fontWeight(selection == question.id ? .bold : .regular)
                    .foregroundColor(Color.primary)
            })
                .buttonStyle(.plain)
        }
        .navigationTitle("all_questions_view_title".localized())
    }

    func getQuestionString(_ question: Question?) -> String {
        var questionString = ""
        let emptyQuestionString = "all_questions_view_empty_question".localized()

        switch viewModel.preferedLanguage {
        case .en: questionString = question?.en ?? emptyQuestionString
        case .es: questionString = question?.es ?? emptyQuestionString
        }

        return questionString
    }
}

struct AllQuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        let questions = [
            Question(id: "1",
                     category: .friends,
                     es: "Prueba",
                     en: "Test",
                     pt: "Prueba",
                     fr: "Prueba",
                     de: "Prueba",
                     author: ""),
            Question(id: "2",
                     category: .friends,
                     es: "Prueba2",
                     en: "Test2",
                     pt: "Prueba2",
                     fr: "Prueba2",
                     de: "Prueba2",
                     author: "")
        ]
        Group {
            AllQuestionsView(
                viewModel: AllQuestionsViewModel(
                    questions: Questions(
                        questions: questions,
                        categories: [])) )

            AllQuestionsView(
                viewModel: AllQuestionsViewModel(
                    questions: Questions(
                        questions: questions,
                        categories: [])) )
                .preferredColorScheme(.dark)
        }
    }
}
