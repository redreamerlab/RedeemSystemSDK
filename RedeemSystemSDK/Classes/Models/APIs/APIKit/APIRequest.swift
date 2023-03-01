//
//  APIRequest.swift
//  REVIEW
//
//  Created by 張家齊 on 2023/3/1.
//

import Foundation

struct APIRequest {
    let header: [String: String]?
    let body: Data?
    let timeout: Float?
    let method: HTTPMethod
}
