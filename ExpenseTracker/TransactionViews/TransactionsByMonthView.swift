//
//  TransactionsByMonthView.swift
//  ExpenseTracker
//
//  Created by Jaejun Shin on 13/10/2022.
//

import SwiftUI

struct TransactionsByMonthView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel

    var body: some View {
        VStack {
            List {
                ForEach(Array(transactionViewModel.groupTransactionByMonth()) , id: \.key) { month, transactions in
                    Section {
                        ForEach(transactions) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    } header: {
                        Text(month)
                            .foregroundColor(.secondary)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.systemBackground)
        .tint(.primary)
    }
}

struct TransactionsByMonthView_Previews: PreviewProvider {
    static let transactionViewModel: TransactionViewModel = {
        let transactionVM = TransactionViewModel()
        transactionVM.transactions = Transaction.previewData
        return transactionVM
    }()

    static var previews: some View {
        TransactionsByMonthView()
            .environmentObject(transactionViewModel)
    }
}
