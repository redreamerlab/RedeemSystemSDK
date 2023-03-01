//
//  PassportTests.swift
//  RedeemSystemSDK_Tests
//
//  Created by 張家齊 on 2023/3/1.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Combine
import XCTest
import RedeemSystemSDK

final class PassportTests: XCTestCase {
    private var collection = Set<AnyCancellable>()
    private var expiredQRCode: String {
        "REDREAMER:eyJuZXR3b3JrIjoicG9seWdvbiIsImNhbXBhaWduX3V1aWQiOiJhNTVkZjFmZS02YmZlLTQwZjYtOTk3Ny03OWQyMjk3MGNiYjciLCJjYW1wYWlnbl9pZCI6ImE1NWRmMWZlLTZiZmUtNDBmNi05OTc3LTc5ZDIyOTcwY2JiNyIsImNvbnRyYWN0X2FkZHJlc3MiOiIweGM1MDU2ZDkwNjY0MGY4OWYzMWJhNmVmZjVlODkzYTFjMWU3YjBiMzIiLCJ0b2tlbl9pZCI6MiwicmVxdWVzdGVyX2FkZHJlc3MiOiIweDg1YjdjYTE2MWMzMTFkOWE1ZjAwNzdkNTA0OGNhZGZhY2U4OWEyNjciLCJoYXNoIjoiYjY3N2UzMjktNjhkZS00YWRiLThjNjItODU5MmUxYmJmMjMzIn0="
    }
    private var qrCode: String {
        "REDREAMER:eyJuZXR3b3JrIjoicG9seWdvbiIsImNhbXBhaWduX3V1aWQiOiJhNTVkZjFmZS02YmZlLTQwZjYtOTk3Ny03OWQyMjk3MGNiYjciLCJjYW1wYWlnbl9pZCI6ImE1NWRmMWZlLTZiZmUtNDBmNi05OTc3LTc5ZDIyOTcwY2JiNyIsImNvbnRyYWN0X2FkZHJlc3MiOiIweGM1MDU2ZDkwNjY0MGY4OWYzMWJhNmVmZjVlODkzYTFjMWU3YjBiMzIiLCJ0b2tlbl9pZCI6NzEsInJlcXVlc3Rlcl9hZGRyZXNzIjoiMHg4NWI3Y2ExNjFjMzExZDlhNWYwMDc3ZDUwNDhjYWRmYWNlODlhMjY3IiwiaGFzaCI6ImI4NDAxOGQwLTVhZGQtNGVkMy1iODQ5LTRiYzViMDNhZTI3YSJ9"
    }
    
    override class func setUp() {
        RedeemSystem.shared.configure(environment: .testnet, apiKey: "8AetTdcKwtrOvZJcPLI5VP2qxL70_kQ9Pkn6SNECrwo=")
    }
    
    func testVerify() {
        let testingQRCodeContent = qrCode
        guard let passportQRCode = PassportQRCode(qrcode: testingQRCodeContent) else {
            XCTFail("Passport QR code decodes failed.")
            return
        }
        let expection = expectation(description: #function)
        Passport.shared.verify(passportQRCode: passportQRCode).sink { [weak expection] completion in
            switch completion {
            case .finished: expection?.fulfill()
            case let .failure(error): XCTFail(error.localizedDescription)
            }
        } receiveValue: { campaign in
            DLogDebug(campaign)
        }
        .store(in: &collection)
        wait(for: [expection], timeout: 3)
    }
    
    func testVerifyWithError() {
        let testingQRCodeContent = expiredQRCode
        guard let passportQRCode = PassportQRCode(qrcode: testingQRCodeContent) else {
            XCTFail("Passport QR code decodes failed.")
            return
        }
        let expection = expectation(description: #function)
        Passport.shared.verify(passportQRCode: passportQRCode).sink { [weak expection] completion in
            switch completion {
            case .finished: XCTFail("It should not work.")
            case let .failure(error): DLogError(error.localizedDescription)
            }
            expection?.fulfill()
        } receiveValue: { campaign in
            DLogDebug(campaign)
        }
        .store(in: &collection)
        wait(for: [expection], timeout: 3)
    }
}
