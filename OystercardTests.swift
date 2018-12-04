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
        sut.top_up(number: 5)
        XCTAssertEqual(sut.myBalance(), 5)
    }
    
    func testThrowErrorIfTopUpOverMaximum() {
        XCTAssertThrowsError(try sut.top_up(number: 91), "Maximum balance allowed is £90")
    }
    
    func testDeductFromBalance() {
        try? sut.top_up(money: 10)
        sut.deduct(money: 5)
        XCTAssertEqual(sut.myBalance(), 5)
    }
    
    func testIfCardInJourney() {
        sut.touch_in("Aldgate")
        XCTAssertEqual(sut.in_journey, true)
    }
    
    func testCardIsTouchedIn() {
        XCTAssertEqual(sut.touch_in("Aldgate"), "You touched in at Aldgate")
    }
    
    func testCardIsTouchedOut() {
        XCTAssertEqual(sut.touch_out("Aldgate East"), "You touched out at Aldgate East")
    }
}

OystercardTests.defaultTestSuite.run()
