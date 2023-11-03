import Foundation

final class CurrencyFormatterService {
    
    // MARK: - Classes:
    let formatter = NumberFormatter()
    
    // MARK: - Public Methods:
    func getAdaptedCurrencyString(from string: String) -> String {
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.minimumFractionDigits = 0
        
        var currencyString = ""
        
        if let intNumber = Int(string.dropLast(2)) {
            let nsNumber = NSNumber(integerLiteral: intNumber)
            currencyString = formatter.string(from: nsNumber) ?? ""
        }
        
        return currencyString
    }
}
