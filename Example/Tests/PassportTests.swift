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
    private let expiredQRCode = "REDREAMER:eyJuZXR3b3JrIjoicG9seWdvbiIsImNhbXBhaWduX3V1aWQiOiJhNTVkZjFmZS02YmZlLTQwZjYtOTk3Ny03OWQyMjk3MGNiYjciLCJjYW1wYWlnbl9pZCI6ImE1NWRmMWZlLTZiZmUtNDBmNi05OTc3LTc5ZDIyOTcwY2JiNyIsImNvbnRyYWN0X2FkZHJlc3MiOiIweGM1MDU2ZDkwNjY0MGY4OWYzMWJhNmVmZjVlODkzYTFjMWU3YjBiMzIiLCJ0b2tlbl9pZCI6MiwicmVxdWVzdGVyX2FkZHJlc3MiOiIweDg1YjdjYTE2MWMzMTFkOWE1ZjAwNzdkNTA0OGNhZGZhY2U4OWEyNjciLCJoYXNoIjoiYjY3N2UzMjktNjhkZS00YWRiLThjNjItODU5MmUxYmJmMjMzIn0="
    private let qrCode = "REDREAMER:eyJuZXR3b3JrIjoicG9seWdvbiIsImNhbXBhaWduX3V1aWQiOiJhNTVkZjFmZS02YmZlLTQwZjYtOTk3Ny03OWQyMjk3MGNiYjciLCJjYW1wYWlnbl9pZCI6ImE1NWRmMWZlLTZiZmUtNDBmNi05OTc3LTc5ZDIyOTcwY2JiNyIsImNvbnRyYWN0X2FkZHJlc3MiOiIweGM1MDU2ZDkwNjY0MGY4OWYzMWJhNmVmZjVlODkzYTFjMWU3YjBiMzIiLCJ0b2tlbl9pZCI6NzEsInJlcXVlc3Rlcl9hZGRyZXNzIjoiMHg4NWI3Y2ExNjFjMzExZDlhNWYwMDc3ZDUwNDhjYWRmYWNlODlhMjY3IiwiaGFzaCI6ImI4NDAxOGQwLTVhZGQtNGVkMy1iODQ5LTRiYzViMDNhZTI3YSJ9"
    private let address = "0x262eb0c34ebd3001992e0b31f70c3b4693281ea6"
    private let messageHash = "0x9fa221912dccf42168b071527fee242664e6660a0aa460d6d25ccc7f21c1952c2c25e3c5b1b92e6e3695a514e62eb4b58270976ea9026bb8097494ab4245bb991c"
    private let campaignUuid = "a55df1fe-6bfe-40f6-9977-79d22970cbb7"
    
    override class func setUp() {
        RedeemSystem.shared.configure(environment: .Testnet, apiKey: "8AetTdcKwtrOvZJcPLI5VP2qxL70_kQ9Pkn6SNECrwo=")
    }
    
    private func login() -> AnyPublisher<Void, RedeemSystemError> {
        Auth.shared.login(address: address, signature: messageHash)
    }
    
    func testValidations() {
        let expectation = expectation(description: #function)
        REVIEW.shared.validations(environment: .Devnet, apiKey: "6I8UY-fP3LAfNUZP8cPHPukrvqryrfyliIepfixkYwE=", network: .polygon)
            .sink { [weak expectation] completion in
                switch completion {
                case .finished: expectation?.fulfill()
                case let .failure(error): XCTFail(error.localizedDescription)
                }
            } receiveValue: { validations in
                validations.forEach {
                    print($0)
                }
            }
            .store(in: &collection)
        wait(for: [expectation], timeout: 3)
    }
    
    func testVerify() {
        let testingQRCodeContent = qrCode
        guard let reviewQRCode = REVIEWQRCode(qrcode: testingQRCodeContent) else {
            XCTFail("Passport QR code decodes failed.")
            return
        }
        let expectation = expectation(description: #function)
        REVIEW.shared.verify(reviewQRCode: reviewQRCode).sink { [weak expectation] completion in
            switch completion {
            case .finished: expectation?.fulfill()
            case let .failure(error): XCTFail(error.localizedDescription)
            }
        } receiveValue: { campaign in
            print(campaign)
        }
        .store(in: &collection)
        wait(for: [expectation], timeout: 3)
    }
    
    func testVerifyWithError() {
        let testingQRCodeContent = expiredQRCode
        guard let reviewQRCode = REVIEWQRCode(qrcode: testingQRCodeContent) else {
            XCTFail("Passport QR code decodes failed.")
            return
        }
        let expectation = expectation(description: #function)
        REVIEW.shared.verify(reviewQRCode: reviewQRCode).sink { [weak expectation] completion in
            switch completion {
            case .finished: XCTFail("It should not work.")
            case let .failure(error): print(error.localizedDescription)
            }
            expectation?.fulfill()
        } receiveValue: { campaign in
            print(campaign)
        }
        .store(in: &collection)
        wait(for: [expectation], timeout: 3)
    }
    
    func testCampaigns() {
        let expectation = expectation(description: #function)
        let readCampaignAPIKey = "ik3NpiqJckVHuu32wUQXYpvTJWXJorWmNGXplNJNKGM="
        Publishers.MergeMany(
            Passport.shared.getCampaigns(network: .eth, apiKey: readCampaignAPIKey),
            Passport.shared.getCampaigns(network: .tt, apiKey: readCampaignAPIKey),
            Passport.shared.getCampaigns(network: .polygon, apiKey: readCampaignAPIKey),
            Passport.shared.getCampaigns(network: .bnb, apiKey: readCampaignAPIKey)
        )
        .collect()
        .map { $0.flatMap { $0 } }
        .sink { completion in
            switch completion {
            case .finished: return
            case let .failure(error): XCTFail(error.localizedDescription)
            }
        } receiveValue: { [weak expectation] campaigns in
            campaigns.forEach {
                print("\($0.network.rawValue): \($0.name) - \($0.uuid)")
            }
            expectation?.fulfill()
        }
        .store(in: &collection)
        wait(for: [expectation], timeout: 3)
    }
    
    func testRNFTs() {
        let expectation = expectation(description: #function)
        login().flatMap { [weak self] _ in
            Passport.shared.getRNFTs(network: .polygon, campaignUuid: self?.campaignUuid ?? "")
        }
        .sink { [weak expectation] completion in
            switch completion {
            case .finished: expectation?.fulfill()
            case let .failure(error): XCTFail(error.localizedDescription)
            }
        } receiveValue: { metadatas in
            print("NFT: \(metadatas.count)")
            metadatas.forEach { print("\($0.contractAddress ?? "") - \($0.tokenId ?? 0)") }
        }
        .store(in: &collection)
        wait(for: [expectation], timeout: 3)
    }
    
    func testRedeem() {
        let contractAddress = "0xc5056d906640f89f31ba6eff5e893a1c1e7b0b32"
        let signature = "0x005304424b27b021138a1165f20926a8c3c162e5004f7204d4628cdab2ede9aa41f766e6dd364d20dc85b5c720cc2e45e7fdf6a81a0e58ffcfd976462ad06b8b1b"
        let tokenId = 2
        let expextation = expectation(description: #function)
        login().flatMap { [weak self] _ in
            Passport.shared.postRedemption(network: .polygon, campaignUuid: self?.campaignUuid ?? "", contractAddress: contractAddress, signature: signature, tokenId: tokenId)
        }
        .sink { completion in
            switch completion {
            case .finished: return
            case let .failure(error): XCTFail(error.localizedDescription)
            }
        } receiveValue: { [weak expextation] redemption in
            print(redemption)
            expextation?.fulfill()
        }
        .store(in: &collection)
        wait(for: [expextation], timeout: 3)
    }
}
