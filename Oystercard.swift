import Foundation

enum OystercardError: Error {
    case maximumLimit(message: String)
}

class Oystercard {
    var balance = 0
    let MAXIMUM_BALANCE = 90
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
    
    func touch_in(station: String) -> String {
        in_journey = true
        return "You touched in at \(station)"
    }
    
    func touch_out(station: String) -> String {
        in_journey = false
        return "You touched out at \(station)"
    }
}
