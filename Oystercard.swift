import Foundation

enum OystercardError: Error {
    case maximumLimit(message: String)
}

class Oystercard {
    var balance = 0
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
