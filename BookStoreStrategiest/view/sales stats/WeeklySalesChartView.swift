//
//  WeeklySalesChartView.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 30/3/2025.
//

import SwiftUI
import Charts

struct WeeklySalesChartView: View {
    
    @Bindable var salesViewModel: SalesViewModel
    @State private var rawSelectedState: Date? = nil
    @Environment(\.calendar) var calendar
    
    var selectedDateValue: (day: Date, sales: Int)? {
        if let rawSelectedState {
            return salesViewModel.salesByWeek.first {
                let startOfWeek = $0.day
                let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) ?? Date()
                
                return (startOfWeek...endOfWeek).contains(rawSelectedState)
            }
        } else { return nil }
    }
    
    var body: some View {
        Chart {
            ForEach(salesViewModel.salesByWeek, id: \.day) { saleDate in
                BarMark(
                    x: .value("Week", saleDate.day, unit: .weekOfYear),
                    y: .value("Sales", saleDate.sales)
                )
                .foregroundStyle(.blue.gradient)
                .opacity((selectedDateValue?.day == nil || selectedDateValue?.day == saleDate.day) ? 1 : 0.5)
            }
            
            if let rawSelectedState {
                RuleMark(x: .value("Selected Date", rawSelectedState, unit: .day))
                    .foregroundStyle(.gray.opacity(0.3))
                    .zIndex(-1)
                    .annotation(position: .top, spacing: 0, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                        selectionPopOver
                    }
            }
        }
        .chartXSelection(value: $rawSelectedState)
    }
    
    @ViewBuilder
    var selectionPopOver: some View {
        if let selectedDateValue {
            VStack {
                Text(selectedDateValue.day.formatted(.dateTime.month().day()))
                Text("\(selectedDateValue.sales) sales")
            }
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(.systemBackground))
                    .shadow(color: .blue, radius: 2)
            }
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











