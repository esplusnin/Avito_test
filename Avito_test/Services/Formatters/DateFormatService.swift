import Foundation

final class DateFormatService {
    let formatter = DateFormatter()
    
    func aduptDateString(from string: String) -> String {
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
