//
//  TransactionRow.swift
//  ExpenseTracker
//
//  Created by Jaejun Shin on 12/10/2022.
//

import SwiftUI

struct TransactionRow: View {
    var transaction: Transaction

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "person")
                .frame(width: 44, height: 44)
                .background(Color.icon)
                .foregroundColor(.white)
                .cornerRadius(20.0)

            VStack(alignment: .leading, spacing: 6) {
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)

                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)

                Text(transaction.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Text(transaction.signedAmount, format: .currency(code: "AUD"))
                .bold()
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.text : .primary)
        }
        .padding([.top, .bottom], 8)
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(transaction: Transaction.example)
    }
}
