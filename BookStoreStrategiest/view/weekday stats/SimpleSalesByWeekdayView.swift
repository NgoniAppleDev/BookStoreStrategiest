//
//  SimpleSalesByWeekdayView.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 31/3/2025.
//

import SwiftUI
import Charts

struct SimpleSalesByWeekdayView: View {
    
    @Bindable var salesViewModel: SalesViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            SalesByWeekdayHeaderView(salesViewModel: salesViewModel)
            
            Chart(salesViewModel.averageSalesByWeekday, id: \.number) {
                BarMark(
                    x: .value("Weekday", weekday(for: $0.number)),
                    y: .value("Average Sales", $0.sales),
                    width: .ratio(0.75)
                )
                .foregroundStyle(Color.accentColor.gradient)
                .opacity($0.number == salesViewModel.highestSellingWeekday?.number ? 1 : 0.5)
            }
            .frame(height: 70)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            
        }
    }
    
    let formatter = DateFormatter()
    func weekday(for number: Int) -> String {
        formatter.weekdaySymbols[number - 1]
    }
}

#Preview {
    SimpleSalesByWeekdayView(
        salesViewModel: .preview
    )
    .padding()
}







