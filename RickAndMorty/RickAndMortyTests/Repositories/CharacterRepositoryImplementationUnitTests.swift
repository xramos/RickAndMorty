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

// MARK: - Get Characters

extension CharacterRepositoryImplementationUnitTests {
    
    func testGetCharactersOK() {
        
        // Given
        let page = 1
        let session = getCharacterSession(statusCode: sucessStatusCode, page: page)
        
        let remote = CharacterRemoteDataSource(baseURL: Constants.testBaseURL,
                                               session: session)
        
        let local = CharacterLocalDataSource(dbManager: DBManager(coreDataStack: TestCoreDataStack()))
        
        sut = CharacterRepositoryImplementation(localDataSource: local,
                                                remoteDatSource: remote)
        
        let exp = expectation(description: "expected characters")
        
        // When
        cancellable = sut.getCharacters(page: page)
            .sink(receiveCompletion: { completion in
            
            switch completion {
            case .finished:
                exp.fulfill()
            case .failure:
                break
            }
            
        }, receiveValue: { characterInformation in
          
            XCTAssertNotNil(characterInformation)
            XCTAssertEqual(characterInformation.pages, 42)
            
            XCTAssertEqual(characterInformation.characters.count, 1)
            
            XCTAssertEqual(characterInformation.characters[0].id, 1)
            XCTAssertEqual(characterInformation.characters[0].name, "Rick")
            XCTAssertEqual(characterInformation.characters[0].status.rawValue, "Alive")
            XCTAssertEqual(characterInformation.characters[0].species, "Human")
            XCTAssertEqual(characterInformation.characters[0].type, "Genetic experiment")
            XCTAssertEqual(characterInformation.characters[0].gender.rawValue, "Male")
            XCTAssertEqual(characterInformation.characters[0].image, "character image")
            XCTAssertEqual(characterInformation.characters[0].originId, 1)
            XCTAssertEqual(characterInformation.characters[0].locationId, 20)
        })
        
        wait(for: [exp], timeout: timeoutTime)
        
        // Then
        XCTAssertNotNil(cancellable)
    }
    
    func testGetCharactersError() {
        
        // Given
        let page = 1
        let session = getCharacterSession(statusCode: failureStatusCode, page: page)
        
        let remote = CharacterRemoteDataSource(baseURL: Constants.testBaseURL,
                                               session: session)
        
        let local = CharacterLocalDataSource(dbManager: DBManager(coreDataStack: TestCoreDataStack()))
        
        sut = CharacterRepositoryImplementation(localDataSource: local,
                                                remoteDatSource: remote)
        
        let exp = expectation(description: "expected characters")
        
        // When
        cancellable = sut.getCharacters(page: page)
            .sink(receiveCompletion: { completion in
            
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
    
    func getCharacterSession(statusCode: Int, page: Int) -> URLSession {
        
        // URL we expect to call
        let url = URL(string: "\(Constants.testBaseURL)/character?page=\(page)")
        
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
                        "info": {
                            "pages": 42
                        },
                        "results":[
                            {
                                "id": 1,
                                "name": "Rick",
                                "status": "Alive",
                                "species": "Human",
                                "type": "Genetic experiment",
                                "gender": "Male",
                                "image": "character image",
                                "origin": {
                                    "name": "Earth",
                                    "url": "https://rickandmortyapi.com/api/location/1"
                                },
                                "location": {
                                    "name": "Earth (Replacement Dimension)",
                                    "url": "https://rickandmortyapi.com/api/location/20"
                                },
                            }
                        ]
                    }
                    """
        
        return Data(dataString.utf8)
    }
}

// MARK: - Get Location

extension CharacterRepositoryImplementationUnitTests {
    
    func testGetLocationOK() {
        
        // Given
        let locationId = 1
        let session = getLocationSession(statusCode: sucessStatusCode, locationId: locationId)
        
        let remote = CharacterRemoteDataSource(baseURL: Constants.testBaseURL,
                                               session: session)
        
        let local = CharacterLocalDataSource(dbManager: DBManager(coreDataStack: TestCoreDataStack()))
        
        sut = CharacterRepositoryImplementation(localDataSource: local,
                                                remoteDatSource: remote)
        
        let exp = expectation(description: "expected location")
        
        // When
        cancellable = sut.getLocation(isForced: true, locationId: locationId)
            .sink(receiveCompletion: { completion in
            
            switch completion {
            case .finished:
                exp.fulfill()
            case .failure:
                break
            }
            
        }, receiveValue: { location in
          
            XCTAssertNotNil(location)
            
            XCTAssertEqual(location.id, 3)
            XCTAssertEqual(location.name, "Citadel of Ricks")
            XCTAssertEqual(location.type, "Space station")
        })
        
        wait(for: [exp], timeout: timeoutTime)
        
        // Then
        XCTAssertNotNil(cancellable)
    }
    
    func testGetLocationError() {
        
        // Given
        let locationId = 1
        let session = getLocationSession(statusCode: failureStatusCode, locationId: locationId)
        
        let remote = CharacterRemoteDataSource(baseURL: Constants.testBaseURL,
                                               session: session)
        
        let local = CharacterLocalDataSource(dbManager: DBManager(coreDataStack: TestCoreDataStack()))
        
        sut = CharacterRepositoryImplementation(localDataSource: local,
                                                remoteDatSource: remote)
        
        let exp = expectation(description: "expected location")
        
        // When
        cancellable = sut.getLocation(isForced: true, locationId: locationId)
            .sink(receiveCompletion: { completion in
                
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
    
    func getLocationSession(statusCode: Int, locationId: Int) -> URLSession {
        
        // URL we expect to call
        let url = URL(string: "\(Constants.testBaseURL)/location/\(locationId)")
        
        // Data we expect to recieve
        let data = getLocationData()
        
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
    
    func getLocationData() -> Data{
        
        let dataString = """
                    {
                        "id": 3,
                        "name": "Citadel of Ricks",
                        "type": "Space station",
                        "dimension": "unknown",
                        "url": "https://rickandmortyapi.com/api/location/3"
                    }
                    """
        
        return Data(dataString.utf8)
    }
}
