//
//  TargetType+request.swift
//  REVIEW
//
//  Created by 張家齊 on 2023/3/1.
//

import Combine
import Foundation

extension TargetType {
    func request() -> AnyPublisher<Self.ResponseType, Error> {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else { preconditionFailure() }
        components.path = endpoint.path
        if endpoint.queryItems.isEmpty == false {
            components.percentEncodedQueryItems = endpoint.queryItems
        }
        guard let url = components.url else { preconditionFailure() }
        DLogDebug(url.absoluteString)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        DLogDebug(request.allHTTPHeaderFields)
        request.httpMethod = method.rawValue
        DLogDebug(request.httpMethod)
        if let body = body {
            request.httpBody = body
            DLogDebug(String(data: body, encoding: .utf8))
        }
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) -> Self.ResponseType in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let value = try? decoder.decode(Self.ResponseType.self, from: data) {
                    DLogInfo(String(data: data, encoding: .utf8))
                    return value
                } else if let value = try? decoder.decode(RedeemSystemErrorResponse.self, from: data) {
                    DLogError(String(data: data, encoding: .utf8))
                    throw value.error
                } else {
                    throw NSError(domain: "io.redremaer", code: 0, userInfo: ["response": response, "data": data])
                }
            }
            .eraseToAnyPublisher()
    }
}
