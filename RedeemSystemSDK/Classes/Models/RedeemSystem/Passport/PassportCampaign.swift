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
     //wax
     {
         "creator": "waxchihkaiyu",
         "image_url": "https://mainnet-cdn.redreamer.io/logo.png",
         "description": "For WAX mainnet",
         "qr_code_source": 0,
         "redeemed_description": "redeemed!",
         "collection_names": [
             "tmnt.funko"
         ],
         "validated_description": "validated!",
         "maximum_validated_count": 0,
         "network": "wax",
         "start_time": "2022-09-01 00:00:00+08:00",
         "after_redeemed": 0,
         "is_public": true,
         "end_time": "2023-12-31 00:00:00+08:00",
         "name": "tmnt.funko Redeem"
     }
     */
    public let uuid: String?
    public let name, description, redeemedDescription, imageUrl, startTime, endTime: String
    public let contractAddresses, collectionNames: [String]?
    public let network: Network
}
