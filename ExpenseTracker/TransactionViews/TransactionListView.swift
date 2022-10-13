//
//  TransactionListView.swift
//  ExpenseTracker
//
//  Created by Jaejun Shin on 13/10/2022.
//

import SwiftUI

struct TransactionListView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Recent Transactions")
                    .bold()

                Spacer()

                NavigationLink {
                    TransactionsByMonthView()
                } label: {
                    HStack {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                }
            }

            VStack {
                ForEach(transactionViewModel.transactions.prefix(5)) { transaction in
                    TransactionRow(transaction: transaction)

                    Divider()
                }
            }
        }
        .padding([.horizontal, .top])
        .background(Color.systemBackground)
        .cornerRadius(20.0)
        .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static let transactionViewModel: TransactionViewModel = {
        let transactionVM = TransactionViewModel()
        transactionVM.transactions = Transaction.previewData
        return transactionVM
    }()

    static var previews: some View {
        TransactionListView()
            .environmentObject(transactionViewModel)
    }
}
