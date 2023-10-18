//
//  REVIEW.swift
//  RedeemSystemSDK
//
//  Created by 張家齊 on 2023/7/7.
//

import Combine

public class REVIEW {
    public static let shared = REVIEW()
    
    private init() {}
}

extension REVIEW {
    public func verify(environment: APIEnvironment? = nil, apiKey: String? = nil, reviewQRCode: REVIEWQRCode) -> AnyPublisher<REVIEWResponse, RedeemSystemError> {
        let apiKey = apiKey ?? RedeemSystem.shared.apiKey
        guard let apiKey = apiKey else { return Fail<REVIEWResponse, RedeemSystemError>(error: .unknown).eraseToAnyPublisher() }
        return REVIEWAPI.VerifyQRCode(
            environment: environment ?? RedeemSystem.shared.environment,
            apiKey: apiKey,
            reviewQRCode: reviewQRCode
        )
        .request()
        .mapRedeemSystemError()
        .eraseToAnyPublisher()
    }
    
    public func validations(environment: APIEnvironment? = nil, apiKey: String? = nil, network: Network) -> AnyPublisher<[REVIEWValidation], RedeemSystemError> {
        let apiKey = apiKey ?? RedeemSystem.shared.apiKey
        guard let apiKey = apiKey else { return Fail<[REVIEWValidation], RedeemSystemError>(error: .unknown).eraseToAnyPublisher() }
        return REVIEWAPI.Validations(environment: environment ?? RedeemSystem.shared.environment, apiKey: apiKey, network: network)
            .request()
            .mapRedeemSystemError()
            .eraseToAnyPublisher()
    }
}
