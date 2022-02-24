//
//  Question.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

struct Question: Decodable {
    let id: String
    let category: QuestionCategory
    let es: String
    let en: String
    let pt: String
    let fr: String
    let de: String
}
