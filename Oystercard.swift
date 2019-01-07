import Foundation

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
