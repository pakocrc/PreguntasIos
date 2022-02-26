//
//  Questions.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

struct Questions: Decodable {
    let questions: [Question]
    let categories: [QuestionCategory]
}
