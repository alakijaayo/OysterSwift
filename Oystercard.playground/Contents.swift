import Foundation
import XCTest

var str = "Hello, playground"

class Oystercard {
    var balance = 0
    func myBalance() -> Int {
        return balance
    }
    
    func top_up(number: Int) -> String {
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
        sut.top_up(number: 5)
        XCTAssertEqual(sut.myBalance(), 5)
    }
}

OystercardTests.defaultTestSuite.run()
