import Foundation


struct BankAccount: Codable {
    
    var depositMoney: Float = 0.0
    
    mutating func addMoney(money: Float) {
        depositMoney += money
    }
    
    mutating func removeMoney(money: Float) {
        depositMoney -= money
    }
}


// user + BankAccount
// 

