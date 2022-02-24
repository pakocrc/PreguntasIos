//
//  NetworkResponse.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

public enum NetworkResponse: Error {
    case success(String)
    case authenticationError
    case badRequest
    case outdated
    case failed(String)
    case noData
    case unableToDecode
}

extension NetworkResponse: Equatable {
    public static func == (lhs: NetworkResponse, rhs: NetworkResponse) -> Bool {
        switch (lhs, rhs) {
        case (NetworkResponse.success, NetworkResponse.success),
            (NetworkResponse.authenticationError, NetworkResponse.authenticationError),
            (NetworkResponse.badRequest, NetworkResponse.badRequest),
            (NetworkResponse.outdated, NetworkResponse.outdated),
            (NetworkResponse.failed, NetworkResponse.failed),
            (NetworkResponse.noData, NetworkResponse.noData),
            (NetworkResponse.unableToDecode, NetworkResponse.unableToDecode):
            return true
        default:
            return false
        }
    }
}
