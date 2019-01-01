import Foundation

class Station {
    var sname: String?
    var szone: Int?
    
    func information(name: String, zone: Int) -> String {
        sname = name
        szone = zone
        return "This is \(name) station and it is in zone \(zone)"
    }
    
}
