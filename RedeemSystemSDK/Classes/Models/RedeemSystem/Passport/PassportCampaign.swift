//
//  PassportCampaign.swift
//  RedeemSystemSDK
//
//  Created by 張家齊 on 2023/3/1.
//

import Foundation

public struct PassportCampaign: Decodable {
    /*
     {
     "id": "7e60b421-369b-40ca-95d8-ca12777801ae",
     "uuid": "7e60b421-369b-40ca-95d8-ca12777801ae",
     "network": "eth",
     "name": "test003",
     "description": "test003",
     "validated_description": "Validated Description",
     "redeemed_description": "Redeemed Description",
     "image_url": "https://miro.medium.com/fit/c/88/88/1*AWZLCEOV3qat9SMG2XGmqw.png",
     "contract_addresses": [
     "0x3ff27815b364682781d39a1969c7470fd966da12",
     "0xfbCbe05A9d883784Cae8827B8820913f3921653d"
     ],
     "start_time": "2022-08-31T16:00:00Z",
     "end_time": "2022-09-30T15:59:59Z",
     "created_at": "2022-09-08T07:21:59.374225Z",
     "updated_at": "2022-09-15T09:08:57.73208Z",
     "deleted_at": "0001-01-01T00:00:00Z"
     }
     */
    public let uuid, name, description, redeemedDescription, imageUrl, startTime, endTime: String
    public let contractAddresses: [String]
    public let network: Network
}
