//
//  TransactionModel.swift
//  ExpenseTracker
//
//  Created by Jaejun Shin on 12/10/2022.
//

import Foundation

enum TransactionType: String {
    case debit = "debit"
    case credit = "credit"
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

    var month: String {
        dateParsed.formatted(.dateTime.year().month(.wide))
    }

    static let example: Transaction = Transaction(id: 1, date: "11/11/2011", institution: "Library", account: "Sj", merchant: "Paul", amount: 11.11, type: "credit", categoryId: 801, category: "Software", isPending: false, isTransfer: true, isExpense: true, isEdited: true)

    static let previewData = [Transaction](repeating: example, count: 10)
}

struct Category {
    let id: Int
    let name: String
    let icon: String
    var mainCategoryID: Int?

    static let example1 = Category(id: 1, name: "Auto & Transport", icon: "car")
    static let example2 = Category(id: 2, name: "Auto & Transport", icon: "bird")
    static let example3 = Category(id: 3, name: "Auto & Transport", icon: "bus")
    static let example4 = Category(id: 4, name: "Auto & Transport", icon: "car")
    static let example5 = Category(id: 5, name: "Auto & Transport", icon: "car")
    static let example6 = Category(id: 6, name: "Auto & Transport", icon: "car")
    static let example7 = Category(id: 7, name: "Auto & Transport", icon: "car")
    static let example8 = Category(id: 8, name: "Auto & Transport", icon: "car")
    static let example9 = Category(id: 9, name: "Auto & Transport", icon: "car")

    static let detail1 = Category(id: 101, name: "Auto & Transport", icon: "car", mainCategoryID: 1)
    static let detail2 = Category(id: 201, name: "Auto & Transport", icon: "car", mainCategoryID: 2)
    static let detail3 = Category(id: 301, name: "Auto & Transport", icon: "car", mainCategoryID: 3)
    static let detail4 = Category(id: 401, name: "Auto & Transport", icon: "car", mainCategoryID: 4)
    static let detail5 = Category(id: 501, name: "Auto & Transport", icon: "car", mainCategoryID: 5)
    static let detail6 = Category(id: 601, name: "Auto & Transport", icon: "car", mainCategoryID: 6)
    static let detail7 = Category(id: 701, name: "Auto & Transport", icon: "car", mainCategoryID: 7)
    static let detail8 = Category(id: 801, name: "Auto & Transport", icon: "car", mainCategoryID: 8)
    static let detail9 = Category(id: 901, name: "Auto & Transport", icon: "car", mainCategoryID: 9)
}

extension Category {
    static let categories: [Category] = [
        .example1,
        .example2,
        .example3,
        .example4,
        .example5,
        .example6,
        .example7,
        .example8,
        .example9
    ]

    static let subCategories: [Category] = [
        .detail1,
        .detail2,
        .detail3,
        .detail4,
        .detail5,
        .detail6,
        .detail7,
        .detail8,
        .detail9
    ]

    static let all = categories + subCategories
}

