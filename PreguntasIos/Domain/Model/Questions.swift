//
//  Questions.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

struct Questions: Decodable {
    let questions: [Question]
    let count: Int

    private enum CodingKeys: String, CodingKey {
        case questions, count
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        questions = try container.decode([Question].self, forKey: .questions)
        count = try container.decode(Int.self, forKey: .count)
    }
}
