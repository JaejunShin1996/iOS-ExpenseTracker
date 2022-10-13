//
//  DateFormatter.swift
//  ExpenseTracker
//
//  Created by Jaejun Shin on 12/10/2022.
//

import Foundation

extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"

        return formatter
    }()
}

extension String {
    func dateParsed() -> Date {
        guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else { return Date() }

        return parsedDate
    }
}

extension Double {
    func roundedDouble() -> Double {
        return (self * 100).rounded() / 100
    }
}
