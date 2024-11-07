//
//  CharacterDetailViewModelUnitTests.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 7/11/24.
//

import XCTest

@testable import RickAndMorty

final class CharacterDetailViewModelUnitTests: XCTestCase {

    var sut: CharacterDetailViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        sut = CharacterDetailViewModel(character: CharacterMock().generateCharacter())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        
        try super.tearDownWithError()
    }

    func testGetLocationIsCalled() {
        
        // Given
        let getLocationUseCase = GetLocationUseCaseMock()
        sut = CharacterDetailViewModel(getLocationUseCase: getLocationUseCase,
                                       character: CharacterMock().generateCharacter())
        
        // When
        sut.getLocations()
        
        // Then
        XCTAssertTrue(getLocationUseCase.isExecuteCalled)
    }
}
