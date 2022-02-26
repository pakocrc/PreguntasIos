//
//  APIErrorMapper.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 25/2/22.
//

import Foundation

struct APIErrorMapper {

    // MARK: - Properties
    let error: APIError

    // MARK: - Public API

    // TODO: Fix these string literals (language)
    var message: String {
        switch error {
        case .unreachable:
            return "You need to have a network connection."
        case .unauthorized:
            return "You need to be signed in."
        case .unknown,
                .failedRequest,
                .invalidResponse:
            return "Network connection failed. Please check your internet connection."
        }
    }
}
