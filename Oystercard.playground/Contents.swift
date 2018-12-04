import Foundation
import XCTest

enum OystercardError: Error {
    case maximumLimit(message: String)
}

class Oystercard {
    var balance = 0
    let MAXIMUM_BALANCE = 90
    func myBalance() -> Int {
        return balance
    }
    
    func top_up(number: Int) throws -> String {
        if number > MAXIMUM_BALANCE {
            throw OystercardError.maximumLimit(message: "Maximum balance allowed is £90")
        }
        balance += number
        return "This has been added to the balance of the card"
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
        try? sut.top_up(number: 5)
        XCTAssertEqual(sut.myBalance(), 5)
    }
    
    func testThrowErrorIfTopUpOverMaximum() {
        XCTAssertThrowsError(try sut.top_up(number: 91), "Maximum balance allowed is £90")
    }
}

OystercardTests.defaultTestSuite.run()
