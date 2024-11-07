//
//  ServerCharacterLocationUnitTests.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 7/11/24.
//

import XCTest

@testable import RickAndMorty

final class ServerCharacterLocationUnitTests: XCTestCase {

    func testConvertToEntity() {
        
        // Given
        let serverLocation = CharacterLocationMock().generateServerCharacterLocation()
        
        // When
        let location = serverLocation.convertToEntity()
        
        // Then
        XCTAssertNotNil(location)
        XCTAssertEqual(location.id, serverLocation.id)
        XCTAssertEqual(location.name, serverLocation.name)
        XCTAssertEqual(location.type, serverLocation.type)
        XCTAssertEqual(location.dimension, serverLocation.dimension)
    }
}
