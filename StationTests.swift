import Foundation

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
