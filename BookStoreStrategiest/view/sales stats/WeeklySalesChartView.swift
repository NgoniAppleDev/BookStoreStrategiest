//
//  WeeklySalesChartView.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 30/3/2025.
//

import SwiftUI
import Charts

struct WeeklySalesChartView: View {
    
    @State var salesViewModel: SalesViewModel
    
    var body: some View {
        Chart(salesViewModel.salesByWeek, id: \.day) { saleData in
            BarMark(
                x: .value("Week", saleData.day, unit: .weekOfYear),
                y: .value("Sales", saleData.sales)
            )
            .foregroundStyle(.blue.gradient)
        }
    }
}

struct PlainDataWeeklySalesChartView: View {
    
    let salesData: [Sale]
    
    var body: some View {
        Chart(salesData) { sale in
            BarMark(
                x: .value("Week", sale.saleDate, unit: .weekOfYear),
                y: .value("Sales", sale.quantity)
            )
            .foregroundStyle(.blue.gradient)
        }
    }
}

#Preview {
    WeeklySalesChartView(
        salesViewModel: SalesViewModel.preview
    )
    .aspectRatio(1, contentMode: .fit)
    .padding()
}

#Preview("Plain Data") {
    PlainDataWeeklySalesChartView(
        salesData: Sale.threeMonthsExamples()
    )
    .aspectRatio(1, contentMode: .fit)
    .padding()
}











