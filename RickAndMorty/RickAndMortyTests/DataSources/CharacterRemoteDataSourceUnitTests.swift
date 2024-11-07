//
//  CharacterRemoteDataSourceUnitTests.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import XCTest

@testable import RickAndMorty

final class CharacterRemoteDataSourceUnitTests: XCTestCase {

    var sut: CharacterRemoteDataSource!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        sut = CharacterRemoteDataSource(baseURL: Constants.testBaseURL)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        
        try super.tearDownWithError()
    }

    func testGetCharactersEndpoint() {
     
        // Given
        let page = 1
        
        // When
        let response = sut.getCharactersEndpoint(page: page)
        
        // Then
        XCTAssertNotNil(response)
        XCTAssertEqual(response.url?.absoluteString, "\(Constants.testBaseURL)/character?page=\(page)")
    }
    
    func testGetCharacterLocationEndpoint() {
        
        // Given
        let locationId = 1
        
        // When
        let response = sut.getLocationEndpoint(locationId: locationId)
        
        // Then
        XCTAssertNotNil(response)
        XCTAssertEqual(response.url?.absoluteString, "\(Constants.testBaseURL)/location/\(locationId)")
    }
}
