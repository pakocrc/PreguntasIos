//
//  Question.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

struct Question: Decodable, Identifiable {
    let id: String
    let category: QuestionCategory
    let es: String
    let en: String
    let pt: String
    let fr: String
    let de: String
    let author: String?
}

extension Question: Equatable {
    static func == (rhs: Question, lhs: Question) -> Bool {
        return rhs.id == lhs.id
    }
}
