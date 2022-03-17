//
//  AllQuestionsViewModel.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 13/3/22.
//

import Foundation

final class AllQuestionsViewModel: ObservableObject {
    @Published private (set) var questions: Questions
    @Published var preferedLanguage = UserSettings().preferedLanguage

    init(questions: Questions) {
        self.questions = questions
    }

    deinit {
        print("AllQuestionsViewModel deinit 🗑")
    }
}
