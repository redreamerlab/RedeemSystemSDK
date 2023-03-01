//
//  Endpoint.swift
//  REVIEW
//
//  Created by 張家齊 on 2023/3/1.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}
