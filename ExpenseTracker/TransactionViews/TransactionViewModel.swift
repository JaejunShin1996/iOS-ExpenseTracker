//
//  TransactionViewModel.swift
//  ExpenseTracker
//
//  Created by Jaejun Shin on 12/10/2022.
//

import Foundation
import Combine

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
}
