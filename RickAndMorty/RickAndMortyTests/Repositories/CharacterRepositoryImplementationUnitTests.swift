//
//  CharacterRepositoryImplementationUnitTests.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import XCTest
import Combine

@testable import RickAndMorty

final class CharacterRepositoryImplementationUnitTests: XCTestCase {

    var sut: CharacterRepository!
    
    var cancellable: AnyCancellable?
    
    let sucessStatusCode = 200
    let failureStatusCode = 401
    let timeoutTime: TimeInterval = 2

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        
        try super.tearDownWithError()
    }
}

// Get Characters

extension CharacterRepositoryImplementationUnitTests {
    
    func testGetCharactersOK() {
        
        // Given
        let session = getCharacterSession(statusCode: sucessStatusCode)
        
        let remote = CharacterRemoteDataSource(baseURL: Constants.testBaseURL,
                                               session: session)
        
        let local = CharacterLocalDataSource(dbManager: DBManager(coreDataStack: TestCoreDataStack()))
        
        sut = CharacterRepositoryImplementation(localDataSource: local,
                                                remoteDatSource: remote)
        
        let exp = expectation(description: "expected characters")
        
        // When
        cancellable = sut.getCharacters().sink(receiveCompletion: { completion in
            
            switch completion {
            case .finished:
                exp.fulfill()
            case .failure:
                break
            }
            
        }, receiveValue: { characters in
          
            XCTAssertNotNil(characters)
            
            XCTAssertEqual(characters.count, 1)
            XCTAssertEqual(characters[0].id, 1)
            XCTAssertEqual(characters[0].name, "Rick")
            XCTAssertEqual(characters[0].status.rawValue, "Alive")
            XCTAssertEqual(characters[0].species, "Human")
            XCTAssertEqual(characters[0].type, "Genetic experiment")
            XCTAssertEqual(characters[0].gender.rawValue, "Male")
            XCTAssertEqual(characters[0].image, "character image")
        })
        
        wait(for: [exp], timeout: timeoutTime)
        
        // Then
        XCTAssertNotNil(cancellable)
    }
    
    func testGetCharactersError() {
        
        // Given
        let session = getCharacterSession(statusCode: failureStatusCode)
        
        let remote = CharacterRemoteDataSource(baseURL: Constants.testBaseURL,
                                               session: session)
        
        let local = CharacterLocalDataSource(dbManager: DBManager(coreDataStack: TestCoreDataStack()))
        
        sut = CharacterRepositoryImplementation(localDataSource: local,
                                                remoteDatSource: remote)
        
        let exp = expectation(description: "expected characters")
        
        // When
        cancellable = sut.getCharacters().sink(receiveCompletion: { completion in
            
            switch completion {
            case .finished:
                break
            case .failure:
                exp.fulfill()
            }
            
        }, receiveValue: { characters in
            
            // nothing
        })
        
        wait(for: [exp], timeout: timeoutTime)
        
        // Then
        XCTAssertNotNil(cancellable)
    }
}

extension CharacterRepositoryImplementationUnitTests {
    
    func getCharacterSession(statusCode: Int) -> URLSession {
        
        // URL we expect to call
        let url = URL(string: "\(Constants.testBaseURL)/character")
        
        // Data we expect to recieve
        let data = getCharacterData()
        
        // attach that to some fixed data in our protocol handler
        URLProtocolMock.testURLs = [url: data]
        URLProtocolMock.response = HTTPURLResponse(url: URL(string: "\(Constants.testBaseURL):8080")!,
                                                   statusCode: statusCode,
                                                   httpVersion: nil,
                                                   headerFields: nil)
        
        // now setup a configuration to use our mock
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        // and ceate the URLSession form that
        let session = URLSession(configuration: config)
        
        return session
    }
    
    func getCharacterData() -> Data {
        
        let dataString = """
                    {
                        "results":[
                            {
                                "id": 1,
                                "name": "Rick",
                                "status": "Alive",
                                "species": "Human",
                                "type": "Genetic experiment",
                                "gender": "Male",
                                "image": "character image"
                            }
                        ]
                    }
                    """
        
        return Data(dataString.utf8)
    }
}
