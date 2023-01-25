//
//  ListViewModelTests.swift
//  HyruleCompendiumTests
//
//  Created by Gabriel Colmenares on 25/01/23.
//

import XCTest
@testable import HyruleCompendium

class ListViewModelTests: XCTestCase {

    private var networkMock: NetworkManagerMock!
    private var coreDataMock: CoreDataManagerMock!
    private var dataManagerMock: DataManagerMock!
    
    
    override func setUp() {
        networkMock = NetworkManagerMock()
        coreDataMock = CoreDataManagerMock()
        dataManagerMock = DataManagerMock(coreDataManager: coreDataMock, networkManager: networkMock)
    }
    
    override func tearDown() {
        networkMock = nil
        coreDataMock = nil
        dataManagerMock = nil
    }
    
    func test_viewModel_getAll_success() async {
        //set up
        let viewModel = ListViewModel(dataManager: dataManagerMock)
        
        //pre-check
        XCTAssertEqual(viewModel.equipmments, [])
        XCTAssertEqual(viewModel.monsters, [])
        XCTAssertEqual(viewModel.materials, [])
        
        //when
        await viewModel.getAll()
        
        //verify
        XCTAssertTrue(viewModel.equipmments.count > 0)
        XCTAssertTrue(viewModel.monsters.count > 0)
        XCTAssertTrue(viewModel.materials.count > 0)
    }
    
    func test_viewModel_getAll_success_and_filterData() async {
        //set up
        let viewModel = ListViewModel(dataManager: dataManagerMock)
        
        //pre-check
        XCTAssertEqual(viewModel.mutableEquipments, [])
        XCTAssertEqual(viewModel.mutableMonsters, [])
        XCTAssertEqual(viewModel.mutableMaterials, [])
        
        //when
        await viewModel.getAll()
        await viewModel.update(on: "boom")
        
        //verify
        XCTAssertTrue(viewModel.mutableEquipments.count < viewModel.equipmments.count ||
                      viewModel.mutableMonsters.count < viewModel.monsters.count ||
                      viewModel.mutableMaterials.count < viewModel.materials.count
        )
    }
    
    func test_viewModel_getAll_success_and_filterData_with_impossibleString() async {
        //set up
        let viewModel = ListViewModel(dataManager: dataManagerMock)
        
        //pre-check
        XCTAssertEqual(viewModel.mutableEquipments, [])
        XCTAssertEqual(viewModel.mutableMonsters, [])
        XCTAssertEqual(viewModel.mutableMaterials, [])
        
        //when
        await viewModel.getAll()
        await viewModel.update(on: "impossibleStringaslkjalsdkdjlkasdjlaskld")
        
        //verify
        XCTAssertTrue(viewModel.mutableEquipments.count == 0)
        XCTAssertTrue(viewModel.mutableMonsters.count  == 0)
        XCTAssertTrue(viewModel.mutableMaterials.count == 0)
    }

}
