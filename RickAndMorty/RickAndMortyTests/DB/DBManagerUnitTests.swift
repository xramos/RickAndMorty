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
        XCTAssertEqual(response[0].name, character.name)
        XCTAssertEqual(response[0].status, character.status)
        XCTAssertEqual(response[0].species, character.species)
        XCTAssertEqual(response[0].type, character.type)
        XCTAssertEqual(response[0].gender, character.gender)
        XCTAssertEqual(response[0].image, character.image)
    }
}
