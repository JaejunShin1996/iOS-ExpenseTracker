//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Jaejun Shin on 12/10/2022.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject private var transactionsViewModel = TransactionViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionsViewModel)
        }
    }
}
