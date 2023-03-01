//
//  TargetType.swift
//  REVIEW
//
//  Created by 張家齊 on 2023/3/1.
//

import Combine
import Foundation

protocol TargetType {
    associatedtype ResponseType: Decodable
    
    var baseURL: URL { get }
    var endpoint: Endpoint { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    
    func request() -> AnyPublisher<Self.ResponseType, Error>
}
