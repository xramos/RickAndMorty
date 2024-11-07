//
//  DBCharacterLocationUnitTests.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 7/11/24.
//

import XCTest

@testable import RickAndMorty

final class DBCharacterLocationUnitTests: XCTestCase {

    func testConvertToEntity() {
        
        // Given
        let dbLocation = CharacterLocationMock().generateDBCharacterLocation()
        
        // When
        let location = dbLocation.convertToEntity()
        
        // Then
        XCTAssertNotNil(location)
        XCTAssertEqual(Int16(location.id), dbLocation.id)
        XCTAssertEqual(location.name, dbLocation.name)
        XCTAssertEqual(location.type, dbLocation.type)
        XCTAssertEqual(location.dimension, dbLocation.dimension)
    }
}
