//
//  RedeemSystemError.swift
//  REVIEW
//
//  Created by 張家齊 on 2023/3/1.
//

import Foundation

public enum RedeemSystemError: LocalizedError {
    case qrCodeExpired, authorization, unknown
    
    public var errorDescription: String? {
        switch self {
        case .unknown: return "Unknown Error."
        case .authorization: return "Authorization is failed."
        case .qrCodeExpired: return "The QR code is expired."
        }
    }
}

struct RedeemSystemErrorResponse: Decodable {
    let code: String
    var error: RedeemSystemError {
        switch code {
        case "QR_CODE_EXPIRED": return .qrCodeExpired
        case "AUTHORIZATION_ERROR": return .authorization
        default: return .unknown
        }
    }
}
