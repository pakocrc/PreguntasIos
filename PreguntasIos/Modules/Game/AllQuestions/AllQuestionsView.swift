//
//  AllQuestionsView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 13/3/22.
//

import SwiftUI

struct AllQuestionsView: View {
    @ObservedObject var viewModel: AllQuestionsViewModel

    var body: some View {
        List {
            ForEach(viewModel.questions.questions, id: \.id) { question in
                Text("\(question.id)) \(getQuestionString(question))")
                    .font(Font.body)
                    .foregroundColor(Color.primary)
            }
        }
        .navigationTitle("all_questions_view_title".localized())
    }

    func getQuestionString(_ question: Question?) -> String {
        var questionString = ""
        let emptyQuestionString = "all_questions_view_empty_question".localized()

        switch viewModel.preferedLanguage {
        case .en: questionString = question?.en ?? emptyQuestionString
        case .es: questionString = question?.es ?? emptyQuestionString
        case .pt: questionString = question?.pt ?? emptyQuestionString
        }

        return questionString
    }
}

struct AllQuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        AllQuestionsView(viewModel: AllQuestionsViewModel(questions: Questions(questions: [], categories: [])) )
    }
}
