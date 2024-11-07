//
//  GetCharactersImplementationUnitTests.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import XCTest

@testable import RickAndMorty

final class GetCharactersImplementationUnitTests: XCTestCase {

    var sut: GetCharactersUseCase!
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        
        try super.tearDownWithError()
    }

    func testIsCalled() {
     
        // Given
        let repository = CharacterRepositoryMock()
        sut = GetCharactersUseCaseImplementation(repository: repository)
        
        // When
        _ = sut.execute(page: 1)
        
        // Then
        XCTAssertTrue(repository.isGetCharactersCalled)
    }
}
