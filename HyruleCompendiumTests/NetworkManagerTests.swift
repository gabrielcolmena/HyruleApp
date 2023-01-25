//
//  HyruleCompendiumTests.swift
//  HyruleCompendiumTests
//
//  Created by Gabriel Colmenares on 19/01/23.
//

import XCTest
@testable import HyruleCompendium

final class NetworkManagerTests: XCTestCase {
    
    private var networkingMock: NetworkProtocol!
    
    override func setUp() {
        networkingMock = NetworkManagerMock()
    }
    
    override func tearDown() {
        networkingMock = nil
    }

    func test_fetchAllData_success() async throws {
        //when
        let all = try! await networkingMock.request(
            session: .shared,
            .all,
            type: All.self
        )
        
        //verify
        XCTAssertEqual(all.equipments.count, 3)
        XCTAssertEqual(all.materials.count, 2)
        XCTAssertEqual(all.monsters.count, 1)
    }
    
    func test_fetchAllData_fail() async throws {
        //when
        do {
            _ = try await networkingMock.request(
                session: .shared,
                .all,
                type: Monster.self //wrong model
            )
        } catch {
            //verify
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it is missing.")
        }
    }
}
