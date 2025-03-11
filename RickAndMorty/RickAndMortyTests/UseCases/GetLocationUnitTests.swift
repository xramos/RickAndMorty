//
//  GetLocationUnitTests.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 7/11/24.
//

import XCTest

@testable import RickAndMorty

final class GetLocationUnitTests: XCTestCase {

    var sut: GetLocationUseCase!
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        
        try super.tearDownWithError()
    }

    func testIsGetLocationCalled() {
     
        // Given
        let repository = CharacterRepositoryMock()
        sut = GetLocationUseCase(repository: repository)
        
        // When
        _ = sut.execute(isForced: true, locationId: 1)
        
        // Then
        XCTAssertTrue(repository.isGetLocationCalled)
    }
}
