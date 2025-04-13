//
//  ContentView.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 29/3/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var salesViewModel: SalesViewModel = .preview
    @State private var expensesViewModel: ExpensesViewModel = .preview
    
    var body: some View {
        NavigationSplitView {
            List {
                
                Section {
                    NavigationLink(destination: DetailBookSalesView(salesViewModel: salesViewModel)) {
                        SimpleBookSalesView(salesViewModel: salesViewModel)
                    }
                }
                
                Section {
                    NavigationLink(destination: SalesByWeekDayView(salesViewModel: salesViewModel)) {
                        SimpleSalesByWeekdayView(salesViewModel: salesViewModel)
                    }
                }
                
                Section {
                    NavigationLink(destination: SalesPerBookCategoryView(salesViewModel: salesViewModel)) {
                        SimpleSalesPerBookCategoryView(salesViewModel: salesViewModel)
                    }
                }
                
                Section {
                    NavigationLink(destination: DetailExpensesView(expensesViewModel: expensesViewModel)) {
                        SimpleExpensesLineChartView(expensesViewModel: expensesViewModel)
                    }
                }
                
            }
            .navigationTitle("Book Store Stats")
        } detail: {
            Text("Select a chart")
        }
    }
}

#Preview {
    ContentView()
}





