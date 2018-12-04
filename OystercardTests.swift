import Foundation
import XCTest

class OystercardTests: XCTestCase {
    var sut: Oystercard!
    
    override func setUp() {
        super.setUp()
        sut = Oystercard()
    }
    
    func testStartBalanceIs0() {
        XCTAssertEqual(sut.myBalance(), 0)
    }
    
    func testCardBalanceIsToppedUp() {
        try? sut.top_up(money: 5)
        XCTAssertEqual(sut.myBalance(), 5)
    }
    
    func testThrowErrorIfTopUpOverMaximum() {
        XCTAssertThrowsError(try sut.top_up(money: 91), "Maximum balance allowed is £90")
    }
    
    func testDeductFromBalance() {
        try? sut.top_up(money: 10)
        sut.deduct(money: 5)
        XCTAssertEqual(sut.myBalance(), 5)
    }
    
    func testIfCardInJourney() {
        try? sut.top_up(money: 5)
        try? sut.touch_in(station: "Aldgate")
        XCTAssertEqual(sut.in_journey, true)
    }
    
    func testCardIsTouchedIn() {
        try? sut.top_up(money: 5)
        XCTAssertEqual(try? sut.touch_in(station: "Aldgate"), "You touched in at Aldgate")
    }
    
    func testCardIsTouchedOut() {
        XCTAssertEqual(sut.touch_out(station: "Aldgate East"), "You touched out at Aldgate East")
    }
    func testThrowMinimumBalanceError() {
        XCTAssertThrowsError(try sut.touch_in(station: "Aldgate"), "Minimum balance on card must be £1")
    }
}

OystercardTests.defaultTestSuite.run()
