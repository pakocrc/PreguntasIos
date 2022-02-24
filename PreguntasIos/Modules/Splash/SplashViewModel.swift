//
//  SplashViewModel.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

import Combine
import Foundation
import SwiftUI

class SplashViewModel: ObservableObject {
//    private let questionsUseCase = QuestionsUseCase()

    @Published private (set) var categories: [QuestionCategory]?
    @Published private (set) var questions: [Question]?
    @Published private (set) var dataLoaded = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        loadData()

        self.$categories.combineLatest(self.$questions)
            .filter({ !($0.0?.isEmpty ?? true) && !($0.1?.isEmpty ?? true) })
            .sink { _ in
                DispatchQueue.main.async { [weak self] in
                    self?.dataLoaded.toggle()
                }
            }.store(in: &cancellables)
    }

    private func loadData() {
        print("Loading data...")
        loadDataMock()
    }

    private func loadDataMock() {
        guard let url = Bundle.main.url(forResource: "preguntas", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let preguntas = try? JSONDecoder().decode([Question].self, from: data) else {
                  print("Unable to load or parse preguntas.json")
                  return
              }

        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in

            DispatchQueue.main.async {
                self?.questions = preguntas
                self?.categories = [QuestionCategory.friends, QuestionCategory.life, QuestionCategory.dirty]
            }
        }
    }
}
