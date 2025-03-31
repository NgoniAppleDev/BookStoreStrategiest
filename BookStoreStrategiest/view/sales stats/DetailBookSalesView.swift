//
//  DetailBookSalesView.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 31/3/2025.
//

import SwiftUI

struct DetailBookSalesView: View {
    enum TimeInterval: String, CaseIterable, Identifiable {
        case day = "Day"
        case week = "Week"
        case month = "Month"
        
        var id: Self { self }
    }
    
    @Bindable var salesViewModel: SalesViewModel
    @State private var selectedTimeInterval: TimeInterval = .day
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker(selection: $selectedTimeInterval) {
                ForEach(TimeInterval.allCases) { interval in
                    Text(interval.rawValue)
                }
            } label: {
                Text("Time Interval for chart")
            }
            .pickerStyle(.segmented)
            
            Group {
                Text("You sold ") +
                Text("\(salesViewModel.totalSales) books")
                    .bold()
                    .foregroundStyle(Color.accentColor) +
                Text(" in the last 90 days.")
            }
            .padding(.vertical)
            
            Group {
                switch selectedTimeInterval {
                case .day:
                    DailySalesChartView(salesData: salesViewModel.salesData)
                case .week:
                    WeeklySalesChartView(salesViewModel: salesViewModel)
                case .month:
                    MonthlySalesChartView(salesData: salesViewModel.salesData)
                }
            }
            .aspectRatio(0.8, contentMode: .fit)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    DetailBookSalesView(
        salesViewModel: .preview
    )
}



