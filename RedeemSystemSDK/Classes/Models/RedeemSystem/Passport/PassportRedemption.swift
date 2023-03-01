//
//  PassportRedemption.swift
//  RedeemSystemSDK
//
//  Created by 張家齊 on 2023/3/1.
//

import Foundation

public struct PassportRedemption: Decodable {
    /*
     {
         "after_redeemed": 0,
         "validated_description": "f",
         "redeemed_description": "f",
         "qr_code": "REDREAMER:eyJuZXR3b3JrIjoiZXRoIiwiY2FtcGFpZ25fdXVpZCI6ImI2MGRlYjlhLTBmZjktNGVhMS1iNDAzLTIwZjM5YjU2MTE2YiIsImNhbXBhaWduX2lkIjoiYjYwZGViOWEtMGZmOS00ZWExLWI0MDMtMjBmMzliNTYxMTZiIiwiY29udHJhY3RfYWRkcmVzcyI6IjB4MWRjNEZGMmZDOWZiNzVlOWFEMjRkZmZiOTc0OTIyNGM3MkIyMGE2NiIsInRva2VuX2lkIjo1MiwicmVxdWVzdGVyX2FkZHJlc3MiOiIweDg1YjdjYTE2MWMzMTFkOWE1ZjAwNzdkNTA0OGNhZGZhY2U4OWEyNjciLCJoYXNoIjoiNDlhYTU2YmYtZGQxYi00ZTYyLTk0NGUtZDEzYTY5MDI1Y2I4In0=",
         "created_at": "2022-11-12T01:08:37.140526318Z"
     }
     */
    public let afterRedeemed: Int
    public let redeemedDescription, qrCode: String
}
