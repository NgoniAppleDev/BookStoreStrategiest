//
//  ContentView.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 29/3/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var salesViewModel: SalesViewModel = .preview
    
    var body: some View {
        NavigationStack {
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
                
            }
            .navigationTitle("Book Store Stats")
        }
    }
}

#Preview {
    ContentView()
}





