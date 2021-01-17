//
//  Date.swift
//  TheMovie
//
//  Created by Ilga Putra on 29/11/20.
//

import Foundation

public extension String {
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = self.date() else { return "" }
        return formatter.string(from: date)
    }
    
    func formatyear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        guard let date = self.date() else { return "" }
        return formatter.string(from: date)
    }
    
    func date() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: self)
    }
}
