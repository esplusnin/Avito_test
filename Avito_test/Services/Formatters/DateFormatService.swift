import Foundation

final class DateFormatService {
    
    // MARK: - Classes:
    let formatter = DateFormatter()
    
    // MARK: - Public Methods:
    func getAdaptedDateString(from string: String) -> String {
        var dateString = ""
        formatter.dateFormat = "yyyy-mm-dd"
        
        if let date = formatter.date(from: string) {
            formatter.locale = Locale(identifier: "ru_RU")
            formatter.dateStyle = .long
            
            dateString = formatter.string(from: date)
        }
        
        return dateString
    }
}
