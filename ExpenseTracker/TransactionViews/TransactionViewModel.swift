//
//  TransactionViewModel.swift
//  ExpenseTracker
//
//  Created by Jaejun Shin on 12/10/2022.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []

    private var cancellables = Set<AnyCancellable>()

    // Generate ViewModel as it initialises
    init() {
        getTransactions()
    }

    // Reading Json data using Combine
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("debug: invalid URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("debug: Error Fetching transactions", error.localizedDescription)
                case .finished:
                    print("Finished fetching transactions")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
            }
            .store(in: &cancellables)
    }

    func groupTransactionByMonth() -> TransactionGroup {
        guard !(transactions.isEmpty) else {
            return [:]
        }

        let groupedTransactions = TransactionGroup(grouping: transactions) { $0.month }

        return groupedTransactions
    }

    func accumulateTransactions() -> TransactionPrefixSum {
        guard !(transactions.isEmpty) else { return [] }

        // the data is not updated so using fixed date.
        let today = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!

        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()

        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }

            sum += dailyTotal
            sum = sum.roundedDouble()
            cumulativeSum.append((date.formatted(.dateTime.year().month().day()), sum))
        }

        return cumulativeSum
    }
}
