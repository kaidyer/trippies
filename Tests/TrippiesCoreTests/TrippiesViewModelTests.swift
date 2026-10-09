import XCTest
@testable import TrippiesCore

final class TrippiesViewModelTests: XCTestCase {
    func testInitializationCreatesDefaultCategories() {
        let viewModel = TrippiesViewModel()

        XCTAssertEqual(Set(viewModel.getTrippieCategories()), Set(["Commutes", "Travel", "Other"]))
        XCTAssertEqual(viewModel.trippies["Commutes"]?.icon, "car.fill")
        XCTAssertEqual(viewModel.trippies["Travel"]?.icon, "airplane.departure")
        XCTAssertEqual(viewModel.trippies["Other"]?.icon, "map.fill")
        XCTAssertTrue(viewModel.trippies.values.allSatisfy { $0.avgDuration == 0 && $0.trippies.isEmpty })
    }

    func testStartAppResetsCategoriesToDefaults() {
        let viewModel = TrippiesViewModel()
        viewModel.addTrippieCategory(icon: "tram.fill", type: "Transit")

        viewModel.startApp()

        XCTAssertEqual(Set(viewModel.getTrippieCategories()), Set(["Commutes", "Travel", "Other"]))
    }

    func testAddTrippieTrimsCategoryAndCreatesCategoryWhenMissing() {
        let viewModel = TrippiesViewModel()
        let date = Date(timeIntervalSince1970: 1_000)

        viewModel.addTrippie(icon: "tram.fill", type: "  Transit\n", duration: 24, date: date)

        let category = viewModel.trippies["Transit"]
        XCTAssertEqual(category?.type, "Transit")
        XCTAssertEqual(category?.icon, "tram.fill")
        XCTAssertEqual(category?.avgDuration, 24)
        XCTAssertEqual(category?.trippies.count, 1)
        XCTAssertEqual(category?.trippies.first?.type, "Transit")
        XCTAssertEqual(category?.trippies.first?.duration, 24)
        XCTAssertEqual(category?.trippies.first?.date, date)
    }

    func testAddTrippieAppendsToExistingCategoryAndRecalculatesIntegerAverage() {
        let viewModel = TrippiesViewModel()
        let firstDate = Date(timeIntervalSince1970: 1_000)
        let secondDate = Date(timeIntervalSince1970: 2_000)

        viewModel.addTrippie(icon: "car.fill", type: "Commutes", duration: 10, date: firstDate)
        viewModel.addTrippie(icon: "ignored.fill", type: "Commutes", duration: 21, date: secondDate)

        let category = viewModel.trippies["Commutes"]
        XCTAssertEqual(category?.icon, "car.fill")
        XCTAssertEqual(category?.trippies.map(\.duration), [10, 21])
        XCTAssertEqual(category?.avgDuration, 15)
        XCTAssertEqual(category?.trippies.map(\.date), [firstDate, secondDate])
    }

    func testAddTrippieCategoryTrimsNameAndAddsEmptyCategory() {
        let viewModel = TrippiesViewModel()

        viewModel.addTrippieCategory(icon: "train.fill", type: "  Rail  ")

        let category = viewModel.trippies["Rail"]
        XCTAssertEqual(category?.type, "Rail")
        XCTAssertEqual(category?.icon, "train.fill")
        XCTAssertEqual(category?.avgDuration, 0)
        XCTAssertTrue(category?.trippies.isEmpty == true)
    }

    func testAddTrippieCategoryDoesNotReplaceExistingCategory() {
        let viewModel = TrippiesViewModel()
        viewModel.addTrippieCategory(icon: "train.fill", type: "Travel")

        XCTAssertEqual(viewModel.trippies["Travel"]?.icon, "airplane.departure")
        XCTAssertEqual(viewModel.trippies["Travel"]?.type, "Travel")
    }

    func testGetTrippieCategoriesReturnsCategoryTypes() {
        let viewModel = TrippiesViewModel()
        viewModel.addTrippieCategory(icon: "train.fill", type: "Rail")

        XCTAssertEqual(Set(viewModel.getTrippieCategories()), Set(["Commutes", "Travel", "Other", "Rail"]))
    }
}
