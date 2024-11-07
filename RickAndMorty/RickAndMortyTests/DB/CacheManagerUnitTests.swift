//
//  CacheManagerUnitTests.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 7/11/24.
//

import XCTest

@testable import RickAndMorty

final class CacheManagerUnitTests: XCTestCase {

    var sut: CacheManager!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        sut = CacheManager(type: CacheType.mock)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut.removeAll()
        sut = nil
        
        super.tearDown()
    }

    func testAddKey() {
        
        // Given
        let path = "key1"
        
        // When
        sut.add(key: path)
        let response = sut.exists(key: path)
        
        // Then
        XCTAssertTrue(response)
    }
    
    func testEvictKey() {
        
        // Given
        let path = "key1"
        
        // When
        sut.add(key: path)
        sut.evict(key: path)
        let response = sut.exists(key: path)
        
        // Then
        XCTAssertFalse(response)
    }
    
    func testExpiredKeyTrue() {
        
        // Given
        let path = "key1"
        let time = CacheTime.none.rawValue
        
        // When
        sut.add(key: path)
        let response = sut.expired(key: path, time: time)
        
        // Then
        XCTAssertTrue(response)
    }
    
    func testExpiredKeyFalse() {
        
        // Given
        let path = "key1"
        let time = CacheTime.long.rawValue
        
        // When
        sut.add(key: path)
        let response = sut.expired(key: path, time: time)
        
        // Then
        XCTAssertFalse(response)
    }
    
    func testExistsTrue() {
        
        // Given
        let path = "key1"
        
        // When
        sut.add(key: path)
        let response = sut.exists(key: path)
        
        // Then
        XCTAssertTrue(response)
    }
    
    func testExistsFalse() {
        
        // Given
        let path = "key1"
        
        // When
        let response = sut.exists(key: path)
        
        // Then
        XCTAssertFalse(response)
    }
    
    func testIsAvailableTrue() {
        
        // Given
        let path = "key1"
        let time = CacheTime.long.rawValue
        
        // When
        sut.add(key: path)
        let response = sut.isAvailable(key: path, cacheTime: time, isReachable: true)
        
        // Then
        XCTAssertTrue(response)
    }
    
    func testIsAvailableFalse() {
        
        // Given
        let path = "key1"
        let time = CacheTime.long.rawValue
        
        // When
        let response = sut.isAvailable(key: path, cacheTime: time, isReachable: false)
        
        // Then
        XCTAssertFalse(response)
    }
}
