import Foundation
import XCTest

enum OystercardError: Error {
    case maximumLimit(message: String)
    case minimumLimit(message: String)
    
}

class Oystercard {
    var balance = 0
    let MAXIMUM_BALANCE = 90
    let MINIMUM_BALANCE = 1
    var in_journey = false
    
    func myBalance() -> Int {
        return balance
    }
    
    func top_up(money: Int) throws -> String {
        if money > MAXIMUM_BALANCE {
            throw OystercardError.maximumLimit(message: "Maximum balance allowed is £90")
        }
        balance += money
        return "This has been added to the balance of the card"
    }
    
    func deduct(money: Int) -> String {
        balance -= money
        return "This has been deducted from the balance of the card"
    }
    
    func touch_in(station: String) throws -> String {
        if balance < MINIMUM_BALANCE {
            throw OystercardError.minimumLimit(message: "Minimum balance on card must be £1")
        }
        in_journey = true
        return "You touched in at \(station)"
    }
    
    func touch_out(station: String) -> String {
        in_journey = false
        return "You touched out at \(station)"
    }
}

let oystercard = Oystercard()
print(oystercard.myBalance())


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
