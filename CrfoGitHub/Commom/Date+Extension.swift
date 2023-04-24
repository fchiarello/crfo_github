import Foundation

extension String {
    func formatStringDate(withFormat format: String = "MM/YYYY") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ssZ"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = format
        
        let finalDateStr = dateFormatter.string(from: date ?? Date())
        
        return finalDateStr
    }
}
