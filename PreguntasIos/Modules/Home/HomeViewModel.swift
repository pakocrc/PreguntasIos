//
//  HomeViewModel.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

import Combine

class HomeViewModel: ObservableObject {
    @Published private (set) var categories: [QuestionCategory]
    @Published private (set) var questions: [Question]

    init(categories: [QuestionCategory], questions: [Question]) {
        self.categories = categories
        self.questions = questions
    }

    // MARK: - ⚙️ Helpers
    func categorySelected(category: QuestionCategory) {
        print("Category \(category.rawValue) selected")
    }

    func settingsSelected() {
        print("Settings button selected")
    }

    deinit {
        print("HomeViewModel deinit 🗑")
    }
}
