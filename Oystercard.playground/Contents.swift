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
    var station_in = [String]()
    var journey: [String: String] = ["Entry": "", "Exit": ""]
    
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
        station_in.append(station)
        journey["Entry"] = station
        return "You touched in at \(station)"
    }
    
    func touch_out(station: String) -> String {
        in_journey = false
        self.deduct(money: 1)
        journey["Exit"] = station
        return "You touched out at \(station)"
    }
    
    func journey_log() -> String {
        return "You started your journey at \(journey["Entry"] ?? "nil") and ended your journey at \(journey["Exit"] ?? "nil")"
    }
    
}

let oystercard = Oystercard()
try? oystercard.top_up(money: 10)
try? oystercard.touch_in(station: "York")
oystercard.touch_out(station: "Dulwich")
print(oystercard.myBalance())
print(oystercard.journey_log())

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
    
    func testMoneyDeductedForFinishedJourney() {
        try? sut.top_up(money: 5)
        sut.touch_out(station: "Aldgate")
        XCTAssertEqual(sut.myBalance(), 4)
    }
    
    func testStoresStationTouchedin() {
        try? sut.top_up(money: 5)
        try? sut.touch_in(station: "Aldgate")
        XCTAssertEqual(sut.station_in, ["Aldgate"])
    }
    
    func testStoresJourneyHistory() {
        try? sut.top_up(money: 5)
        try? sut.touch_in(station: "Aldgate")
        sut.touch_out(station: "Denmark Hill")
        XCTAssertEqual(sut.journey, ["Entry": "Aldgate", "Exit": "Denmark Hill"])
    }
    
    func testInformsOfJourney() {
        try? sut.top_up(money: 5)
        try? sut.touch_in(station: "Aldgate")
        sut.touch_out(station: "Denmark Hill")
        XCTAssertEqual(sut.journey_log(), "You started your journey at Aldgate and ended your journey at Denmark Hill")
    }
    
}

OystercardTests.defaultTestSuite.run()


class Station {
    var sname: String?
    var szone: Int?
    
    func information(name: String, zone: Int) -> String {
        sname = name
        szone = zone
        return "This is \(name) station and it is in zone \(zone)"
    }
    
}

class StationTests: XCTestCase {
    var sut: Station!
    
    override func setUp() {
        super.setUp()
        sut = Station()
    }
    
    func testGivesStationsName() {
        sut.information(name: "Aldgate", zone: 1)
        XCTAssertEqual(sut.sname, "Aldgate")
    }
    
    func testGivesStationsZone() {
        sut.information(name: "Aldgate", zone: 1)
        XCTAssertEqual(sut.szone, 1)
    }
    
    func testInformsOfStationDetails() {
        XCTAssertEqual(sut.information(name: "Aldgate", zone:1), "This is Aldgate station and it is in zone 1")
    }
}

StationTests.defaultTestSuite.run()
