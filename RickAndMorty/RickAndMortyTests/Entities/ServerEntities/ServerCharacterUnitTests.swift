//
//  ServerCharacterUnitTests.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 5/11/24.
//

import XCTest

@testable import RickAndMorty

final class ServerCharacterUnitTests: XCTestCase {

    func testConvertToEntity() {
        
        // Given
        let serverCharacter = CharacterMock().generateServerCharacter()
        
        // When
        let character = serverCharacter.convertToEntity()
        
        // Then
        XCTAssertEqual(character.id, serverCharacter.id)
        XCTAssertEqual(character.name, serverCharacter.name)
        XCTAssertEqual(character.status.rawValue, serverCharacter.status)
        XCTAssertEqual(character.species, serverCharacter.species)
        XCTAssertEqual(character.type, serverCharacter.type)
        XCTAssertEqual(character.gender.rawValue, serverCharacter.gender)
        XCTAssertEqual(character.image, serverCharacter.image)
    }
}
