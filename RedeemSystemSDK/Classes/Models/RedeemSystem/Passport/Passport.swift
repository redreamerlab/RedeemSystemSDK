//
//  Passport.swift
//  RedeemSystemSDK
//
//  Created by 張家齊 on 2023/3/1.
//

import Combine

public class Passport {
    public static let shared = Passport()
    
    private init() {}
}

extension Passport {
    public func verify(passportQRCode: PassportQRCode) -> AnyPublisher<PassportCampaign, RedeemSystemError> {
        guard let apiKey = RedeemSystem.shared.apiKey else { return Fail<PassportCampaign, RedeemSystemError>(error: .unknown).eraseToAnyPublisher() }
        return PassportAPI.Verify(
            environment: RedeemSystem.shared.environment,
            apiKey: apiKey,
            passportQRCode: passportQRCode
        )
        .request()
        .mapError { error in
            if let error = error as? RedeemSystemError {
                return error
            } else {
                return RedeemSystemError.unknown
            }
        }
        .eraseToAnyPublisher()
    }
}
