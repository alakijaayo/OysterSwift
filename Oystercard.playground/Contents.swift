import Foundation
import XCTest

class Journey {
    var check_in: String?
    var check_out: String?
    var paid_fare = 0
    
    func tube_in(name: String) -> String {
        check_in = name
        return name
    }
    
    func tube_out(name: String) -> String {
        check_out = name
        return name
    }
    
    func fare() -> Int {
        if check_in != nil && check_out != nil {
            paid_fare = 1
            return paid_fare
        } else if check_in != nil || check_out != nil {
            paid_fare = 6
            return paid_fare
        }
        return paid_fare
    }
}

enum OystercardError: Error {
    case maximumLimit(message: String)
    case minimumLimit(message: String)
    
}

class Oystercard {
    var balance = 0
    let MAXIMUM_BALANCE = 90
    let MINIMUM_BALANCE = 1
    var journey = Journey()
    
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
        } else if journey.check_in != nil {
            self.balance -= journey.fare()
            return "You have already tapped in at another station, you will be charged a penalty fare."
        }
        journey.check_in = station
        return "You touched in at \(station)"
    }
    
    func touch_out(station: String) -> String {
        journey.check_out = station
        self.balance -= journey.fare()
        return "You touched out at \(station)"
    }
    
    func journey_log() -> String {
        return "You started your journey at \(journey.check_in ?? "nil") station and ended your journey at \(journey.check_out ?? "nil") station"
    }
    
}


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
        XCTAssertEqual(sut.journey.check_in, "Aldgate")
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
        XCTAssertEqual(sut.journey.check_in, "Aldgate")
    }
    
    func testInformsOfJourney() {
        try? sut.top_up(money: 5)
        try? sut.touch_in(station: "Aldgate")
        sut.touch_out(station: "Denmark Hill")
        XCTAssertEqual(sut.journey_log(), "You started your journey at Aldgate station and ended your journey at Denmark Hill station")
    }
    
}

OystercardTests.defaultTestSuite.run()

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
        XCTAssertEqual(sut.information(name: "Aldgate", zone: 1), "This is Aldgate station and it is in zone 1")
    }
}

StationTests.defaultTestSuite.run()
