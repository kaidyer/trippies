import XCTest
@testable import Trippies

final class TrippiesViewModelTests: XCTestCase {
    private var defaults: UserDefaults!
    private var suiteName: String!

    override func setUp() {
        super.setUp()
        suiteName = "TrippiesViewModelTests.\(UUID().uuidString)"
        defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
    }

    override func tearDown() {
        defaults.removePersistentDomain(forName: suiteName)
        defaults = nil
        suiteName = nil
        super.tearDown()
    }

    func testFirstLaunchSeedsAndPersistsBuiltInCategories() throws {
        let viewModel = TrippiesViewModel(defaults: defaults)

        XCTAssertEqual(Set(viewModel.getTrippieCategories()), Set(["Commutes", "Travel", "Other"]))
        XCTAssertEqual(viewModel.trippies["Commutes"]?.icon, "car.fill")
        XCTAssertEqual(viewModel.trippies["Travel"]?.icon, "airplane.departure")
        XCTAssertEqual(viewModel.trippies["Other"]?.icon, "map.fill")
        XCTAssertNotNil(defaults.data(forKey: "trippies.categories.v1"))
    }

    func testSavedCategoriesAndTripsLoadAfterReinitialization() {
        let first = TrippiesViewModel(defaults: defaults)
        let tripDate = Date(timeIntervalSince1970: 1_700_000_000)
        XCTAssertTrue(first.addTrippieCategory(icon: "tram.fill", type: "Transit"))
        XCTAssertTrue(first.addTrippie(icon: "tram.fill", type: "Transit", duration: 24, date: tripDate))

        let second = TrippiesViewModel(defaults: defaults)

        XCTAssertEqual(second.trippies["Transit"]?.trippies.count, 1)
        XCTAssertEqual(second.trippies["Transit"]?.trippies.first?.duration, 24)
        XCTAssertEqual(second.trippies["Transit"]?.trippies.first?.date, tripDate)
        XCTAssertEqual(second.trippies["Transit"]?.avgDuration, 24)
        XCTAssertEqual(second.trippies["Transit"]?.id, first.trippies["Transit"]?.id)
        XCTAssertEqual(second.trippies["Transit"]?.trippies.first?.id, first.trippies["Transit"]?.trippies.first?.id)
    }

    func testCorruptSavedDataIsPreservedAndBuiltInsAreRestored() {
        let corruptData = Data("not valid category JSON".utf8)
        defaults.set(corruptData, forKey: "trippies.categories.v1")

        let viewModel = TrippiesViewModel(defaults: defaults)

        XCTAssertEqual(Set(viewModel.getTrippieCategories()), Set(["Commutes", "Travel", "Other"]))
        XCTAssertEqual(defaults.data(forKey: "trippies.categories.v1.corrupt-backup"), corruptData)
        // Keep the corrupt original available as well as its recovery copy.
        XCTAssertEqual(defaults.data(forKey: "trippies.categories.v1"), corruptData)
    }

    func testAddingCategoryTrimsNameAndRejectsDuplicates() {
        let viewModel = TrippiesViewModel(defaults: defaults)

        XCTAssertTrue(viewModel.addTrippieCategory(icon: "tram.fill", type: "  Transit  "))
        XCTAssertEqual(viewModel.trippies["Transit"]?.type, "Transit")
        XCTAssertFalse(viewModel.addTrippieCategory(icon: "bus.fill", type: "Transit"))
        XCTAssertFalse(viewModel.addTrippieCategory(icon: "bus.fill", type: "transit"))
        XCTAssertEqual(viewModel.trippies["Transit"]?.icon, "tram.fill")
    }

    func testCategoryValidationRejectsBlankNamesAndMissingIcons() {
        let viewModel = TrippiesViewModel(defaults: defaults)

        XCTAssertFalse(viewModel.addTrippieCategory(icon: "tram.fill", type: " \n "))
        XCTAssertFalse(viewModel.addTrippieCategory(icon: "", type: "Transit"))
        XCTAssertFalse(viewModel.hasTrippieCategory(named: "   "))
        XCTAssertFalse(viewModel.hasTrippieCategory(named: "Transit"))
        XCTAssertNil(viewModel.trippies[""])
    }

    func testAddingTripsUpdatesAverageAndRejectsInvalidInputs() {
        let viewModel = TrippiesViewModel(defaults: defaults)
        XCTAssertTrue(viewModel.addTrippieCategory(icon: "tram.fill", type: "Transit"))
        let date = Date(timeIntervalSince1970: 1_700_000_000)

        XCTAssertFalse(viewModel.addTrippie(icon: "tram.fill", type: "Transit", duration: 0, date: date))
        XCTAssertFalse(viewModel.addTrippie(icon: "tram.fill", type: "Transit", duration: -1, date: date))
        XCTAssertFalse(viewModel.addTrippie(icon: "tram.fill", type: "Missing", duration: 10, date: date))
        XCTAssertFalse(viewModel.addTrippie(icon: "tram.fill", type: " \n ", duration: 10, date: date))
        XCTAssertEqual(viewModel.trippies["Transit"]?.trippies.count, 0)

        XCTAssertTrue(viewModel.addTrippie(icon: "tram.fill", type: "Transit", duration: 10, date: date))
        XCTAssertTrue(viewModel.addTrippie(icon: "tram.fill", type: "Transit", duration: 21, date: date))

        XCTAssertEqual(viewModel.trippies["Transit"]?.trippies.count, 2)
        XCTAssertEqual(viewModel.trippies["Transit"]?.avgDuration, 15)
    }
}
