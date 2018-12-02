import Foundation

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
