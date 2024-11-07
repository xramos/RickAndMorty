//
//  CharacterLocalDataSourceUnitTests.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import XCTest

@testable import RickAndMorty

final class CharacterLocalDataSourceUnitTests: XCTestCase {

    var sut: CharacterLocalDataSource!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        sut = CharacterLocalDataSource(dbManager: DBManager(coreDataStack: TestCoreDataStack()))
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
    }
    
    func testSaveLocation() {
        
        // Given
        let location = CharacterLocationMock().generateCharacterLocation()
        
        // When
        sut.saveLocation(location: location)
        let response = sut.getLocations()
        
        // Then
        XCTAssertEqual(response.count, 1)
    }
    
    func testGetLocationById() {
        
        // Given
        let locationId = 3
        let location = CharacterLocationMock().generateCharacterLocation(id: locationId)
        
        // When
        sut.saveLocation(location: location)
        let response = sut.getLocationById(id: locationId)
        
        // Then
        XCTAssertNotNil(response)
        XCTAssertEqual(response!.id, locationId)
    }
}
