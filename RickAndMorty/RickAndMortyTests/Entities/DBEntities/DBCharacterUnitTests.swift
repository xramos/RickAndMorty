//
//  DBCharacterUnitTests.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import XCTest

@testable import RickAndMorty

final class DBCharacterUnitTests: XCTestCase {

    func testConvertToEntity() {
        
        // Given
        let dbCharacter = CharacterMock().generateDBCharacter()
        
        // When
        let character = dbCharacter.convertToEntity()
        
        // Then
        XCTAssertEqual(Int16(character.id), dbCharacter.id)
        XCTAssertEqual(character.name, dbCharacter.name)
        XCTAssertEqual(character.status.rawValue, dbCharacter.status)
        XCTAssertEqual(character.species, dbCharacter.species)
        XCTAssertEqual(character.type, dbCharacter.type)
        XCTAssertEqual(character.gender.rawValue, dbCharacter.gender)
        XCTAssertEqual(character.image, dbCharacter.image)
    }
}
