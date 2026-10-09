import SwiftUI
import UIKit
import XCTest
@testable import Trippies

@MainActor
final class MyTrippiesViewTests: XCTestCase {
    func testEmptyCategoryViewRendersInsideNavigationStack() {
        let category = TrippieCategory(
            icon: "airplane.departure",
            type: "Travel",
            avgDuration: 0,
            trippies: []
        )

        XCTAssertNotNil(render(category: category))
    }

    func testCategoryWithTripsRendersInsideNavigationStack() {
        let category = TrippieCategory(
            icon: "airplane.departure",
            type: "Travel",
            avgDuration: 35,
            trippies: [
                Trippie(date: Date(timeIntervalSince1970: 1_700_000_000), duration: 35, type: "Travel"),
                Trippie(date: Date(timeIntervalSince1970: 1_700_000_100), duration: 35, type: "Travel")
            ]
        )

        XCTAssertNotNil(render(category: category))
    }

    private func render(category: TrippieCategory) -> UIImage? {
        let renderer = ImageRenderer(
            content: NavigationStack {
                MyTrippiesView(trippieCategory: category)
            }
        )
        renderer.proposedSize = ProposedViewSize(width: 390, height: 844)
        return renderer.uiImage
    }
}
