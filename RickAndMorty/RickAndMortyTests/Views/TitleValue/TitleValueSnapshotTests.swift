//
//  TitleValueSnapshotTests.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 7/11/24.
//

import XCTest
import PreviewSnapshotsTesting

@testable import RickAndMorty

final class TitleValueSnapshotTests: XCTestCase {

    func testTitleValueSnapshots() {
        
        TitleValueView_Previews.snapshots.assertSnapshots(as: .image(perceptualPrecision: Constants.snapshotsPerceptualPrecision,
                                                                     layout: .device(config: .iPhoneX(.portrait))))
    }
}
