//
//  Auth.swift
//  RedeemSystemSDK
//
//  Created by 張家齊 on 2023/3/1.
//

import Foundation
import Combine

public class Auth {
    public static let shared = Auth()
    
    private init() {}
}

extension Auth {
    public func loginSignMessage(environment: APIEnvironment? = nil, address: String) -> AnyPublisher<String, RedeemSystemError> {
        AuthAPI.GetNonce(
            environment: environment ?? RedeemSystem.shared.environment,
            address: address
        )
        .request()
        .mapRedeemSystemError()
        .map { "\(address) \($0.nonce)" }
        .eraseToAnyPublisher()
    }
    
    public func login(environment: APIEnvironment? = nil, address: String, signature: String) -> AnyPublisher<Void, RedeemSystemError> {
        AuthAPI.Login(address: address, signature: signature, environment: environment ?? RedeemSystem.shared.environment)
            .request()
            .mapRedeemSystemError()
            .map { response in
                RedeemSystem.shared.accessToken = response.token
                RedeemSystem.shared.refreshToken = response.refreshToken
            }
            .eraseToAnyPublisher()
    }
}
