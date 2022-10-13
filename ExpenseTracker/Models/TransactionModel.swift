//
//  TransactionModel.swift
//  ExpenseTracker
//
//  Created by Jaejun Shin on 12/10/2022.
//

import Foundation

enum TransactionType: String {
    case debit = "Debit"
    case credit = "Credit"
}

struct Transaction: Identifiable, Decodable {
    let id: Int
    let date: String
    let institution: String
    let account: String
    var merchant: String
    let amount: Double
    let type: TransactionType.RawValue
    var categoryId: Int
    var category: String
    let isPending: Bool
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool

    var dateParsed: Date {
        date.dateParsed()
    }

    var signedAmount: Double {
        return type == TransactionType.credit.rawValue ? amount : -amount
    }

    static let example: Transaction = Transaction(id: 1, date: "11/11/2011", institution: "Library", account: "Sj", merchant: "Paul", amount: 11.11, type: "Credit", categoryId: 801, category: "Software", isPending: false, isTransfer: true, isExpense: true, isEdited: true)

    static let previewData = [Transaction](repeating: example, count: 10)
}


