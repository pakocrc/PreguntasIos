//
//  EndpointType.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var locale: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
