//
//  CharacterListViewModelUnitTests.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import XCTest

@testable import RickAndMorty

final class CharacterListViewModelUnitTests: XCTestCase {

    var sut: CharacterListViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        sut = CharacterListViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        
        try super.tearDownWithError()
    }

    func testGetCharactersCalled() {
        
        // Given
        let getCharactersUseCase = GetCharactersUseCaseMock()
        sut = CharacterListViewModel(getCharactersUseCase: getCharactersUseCase)
        
        // When
        sut.getCharacters()
        
        // Then
        XCTAssertTrue(getCharactersUseCase.isExecuteCalled)
    }

}
