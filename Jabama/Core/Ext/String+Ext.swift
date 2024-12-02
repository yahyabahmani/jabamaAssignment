//
//  String+Ext.swift
//  Ludo
//
//  Created by mohsen mokhtari on 6/24/23.
//

import Foundation

extension String {
    private static var digits = UnicodeScalar("0")..."9"
    var digits: String {
        return String(unicodeScalars.filter(String.digits.contains))
    }
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date

    }
    
    func isEmail() -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: self)
    }
    
    func getAlphabet() -> String{
        let pattern = "[A-Za-z\u{0100}-\u{FFFF}&&[^\u{0600}-\u{06FF}\u{FB50}-\u{FDFF}\u{FE70}-\u{FEFF}]]|\\s" // Match letters and spaces, exclude Persian
            let regex = try? NSRegularExpression(pattern: pattern, options: [])
            let matches = regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) ?? []
            
            let result = matches.compactMap { match -> String? in
                if let range = Range(match.range, in: self) {
                    return String(self[range])
                }
                return nil
            }
            
            return result.joined().trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func getPersianAlphabet() -> String{
        let pattern = "[\u{0600}-\u{06FF}\u{FB50}-\u{FDFF}\u{FE70}-\u{FEFF}]|\\s"
           let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let matches = regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) ?? []
           
           let result = matches.compactMap { match -> String? in
               if let range = Range(match.range, in: self) {
                   return String(self[range])
               }
               return nil
           }
           
           return result.joined().trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    
}
