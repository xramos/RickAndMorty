//
//  DBManagerUnitTests.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 5/11/24.
//

import XCTest

@testable import RickAndMorty

final class DBManagerUnitTests: XCTestCase {

    var sut: DBManager!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        sut = DBManager(coreDataStack: TestCoreDataStack())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        
        try super.tearDownWithError()
    }

    func testSaveCharacter() {
     
        // Given
        let character = CharacterMock().generateCharacter()
        
        // When
        sut.saveCharacter(character: character)
        let response = sut.getCharacters()
        
        // Then
        XCTAssertEqual(response.count, 1)
        XCTAssertEqual(response[0].id, character.id)
        XCTAssertEqual(response[0].name, character.name)
        XCTAssertEqual(response[0].status, character.status)
        XCTAssertEqual(response[0].species, character.species)
        XCTAssertEqual(response[0].type, character.type)
        XCTAssertEqual(response[0].gender, character.gender)
        XCTAssertEqual(response[0].image, character.image)
    }
    
    func testSaveLocation() {
        
        // Given
        let location = CharacterLocationMock().generateCharacterLocation()
        
        // When
        sut.saveLocation(location: location)
        let response = sut.getLocations()
        
        // Then
        XCTAssertEqual(response.count, 1)
        XCTAssertEqual(response[0].id, location.id)
        XCTAssertEqual(response[0].name, location.name)
        XCTAssertEqual(response[0].type, location.type)
        XCTAssertEqual(response[0].dimension, location.dimension)
    }
    
    func testGetLocationById() {
        
        // Given
        let locationId = 6
        let location = CharacterLocationMock().generateCharacterLocation(id: locationId)
        
        // When
        sut.saveLocation(location: location)
        let response = sut.getLocationById(id: locationId)
        
        // Then
        XCTAssertNotNil(location)
        XCTAssertEqual(response!.id, locationId)
        XCTAssertEqual(response!.name, location.name)
        XCTAssertEqual(response!.type, location.type)
        XCTAssertEqual(response!.dimension, location.dimension)
    }
}
