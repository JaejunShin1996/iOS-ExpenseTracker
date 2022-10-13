//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Jaejun Shin on 12/10/2022.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("OverView")
                        .font(.title2)
                        .bold()

                    CardView {
                        VStack {
                            ChartLabel("$900", type: .title)
                            LineChart()
                        }
                        .background(Color.systemBackground)
                    }
                    .data(demoData)
                    .chartStyle(
                        ChartStyle(
                        backgroundColor: Color.systemBackground,
                        foregroundColor:
                            ColorGradient(Color.icon.opacity(0.4), Color.icon)
                        )
                    )
                    .frame(height: 300)

                    TransactionListView()
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionViewModel: TransactionViewModel = {
        let transactionVM = TransactionViewModel()
        transactionVM.transactions = Transaction.previewData
        return transactionVM
    }()

    static var previews: some View {
        ContentView()
            .environmentObject(transactionViewModel)
    }
}
