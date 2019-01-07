import Foundation

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
