import Foundation

extension String {
    
    enum ValidityType{
        case onlyLetter
        case onlyNumber
    }
    
    enum Regex: String {
        case onlyLetter = "[А-Яа-я]{1,100}"
        case onlyNumber = "[0-9]"
    }
    
    func isValid(_ validityType: ValidityType) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityType {
        case .onlyLetter:
            regex = Regex.onlyLetter.rawValue
        case .onlyNumber:
            regex = Regex.onlyNumber.rawValue
        }
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
