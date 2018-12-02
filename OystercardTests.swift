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
}

OystercardTests.defaultTestSuite.run()
