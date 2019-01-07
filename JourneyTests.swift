import Foundation

class JourneyTests: XCTestCase {
    var sut: Journey!
    
    override func setUp() {
        super.setUp()
        sut = Journey()
    }
    
    func testStoresCheckInStation() {
        sut.tube_in(name: "Aldgate")
        XCTAssertEqual(sut.check_in, "Aldgate")
    }
    
    func testStoresCheckOutStation() {
        sut.tube_out(name: "Elephant & Castle")
        XCTAssertEqual(sut.check_out, "Elephant & Castle")
    }
    
    func testInformsStationYouCheckedIn() {
        XCTAssertEqual(sut.tube_in(name: "Elephant & Castle"), "Elephant & Castle")
    }
    
    func testInformsStationYouCheckedOut() {
        XCTAssertEqual(sut.tube_out(name: "Denmark Hill"), "Denmark Hill")
    }
    
    func testChargesForAJourney() {
        sut.tube_in(name: "Aldgate")
        sut.tube_out(name: "Elephant & Castle")
        sut.fare()
        XCTAssertEqual(sut.paid_fare, 1)
    }
    
    func testChargesForIncompleteJourney() {
        sut.tube_out(name: "Elephant & Castle")
        sut.fare()
        XCTAssertEqual(sut.paid_fare, 6)
    }
}

JourneyTests.defaultTestSuite.run()
