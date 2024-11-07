//
//  CharacterCellViewSnapshotTests.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import XCTest
import PreviewSnapshotsTesting

@testable import RickAndMorty

final class CharacterCellViewSnapshotTests: XCTestCase {

    func testCharacterCellSnapshots() {
        
        CharacterCellView_Previews.snapshots.assertSnapshots(as: .image(perceptualPrecision: Constants.snapshotsPerceptualPrecision,
                                                                        layout: .device(config: .iPhoneX(.portrait))))
    }
}
