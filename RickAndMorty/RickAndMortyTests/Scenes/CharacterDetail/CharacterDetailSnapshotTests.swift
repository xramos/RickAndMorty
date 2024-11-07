//
//  CharacterDetailSnapshotTests.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 7/11/24.
//

import XCTest
import PreviewSnapshotsTesting

@testable import RickAndMorty

final class CharacterDetailSnapshotTests: XCTestCase {

    func testCharacterDetailSnapshots() {
        
        CharacterDetailView_Previews.snapshots
            .assertSnapshots(as: .image(perceptualPrecision: Constants.snapshotsPerceptualPrecision,
                                                                        layout: .device(config: .iPhoneX(.portrait))))
    }
}
