//
//  APIError.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

public enum APIError: Error {
    case unknown
    case unreachable
    case unauthorized
    case failedRequest
    case invalidResponse
}

extension APIError: Equatable {
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (APIError.unknown, APIError.unknown),
            (APIError.unreachable, APIError.unreachable),
            (APIError.unauthorized, APIError.unauthorized),
            (APIError.failedRequest, APIError.failedRequest),
            (APIError.invalidResponse, APIError.invalidResponse):
            return true
        default:
            return false
        }
    }
}
