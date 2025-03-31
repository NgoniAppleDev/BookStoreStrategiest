//
//  SalesByWeekDayView.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 31/3/2025.
//

import SwiftUI
import Charts

struct SalesByWeekDayView: View {
    
    @Bindable var salesViewModel: SalesViewModel
    @State private var medianSalesIsSShown: Bool = true
    @State private var individualDaysAreShown: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            SalesByWeekdayHeaderView(salesViewModel: salesViewModel)
            
            Chart {
                ForEach(salesViewModel.averageSalesByWeekday, id: \.number) {
                    BarMark(
                        x: .value("Weekday", weekday(for: $0.number)),
                        y: .value("Average Sales", $0.sales),
                        width: .ratio(0.75)
                    )
                    .foregroundStyle(Color.gray)
                    .opacity(0.3)
                    
                    RectangleMark(
                        x: .value("Weekday", weekday(for: $0.number)),
                        y: .value("Average Sales", $0.sales),
                        height: 3
                    )
                    .foregroundStyle(.gray)
                }
                
                if medianSalesIsSShown {
                    RuleMark(y: .value("Median Sales", salesViewModel.medianSales))
                        .foregroundStyle(.indigo)
                        .annotation(position: .top, alignment: .trailing) {
                            Text("Median: \(String(format: "%.2f", salesViewModel.medianSales))")
                                .font(.body.bold())
                                .foregroundStyle(.indigo)
                        }
                }
                
                if individualDaysAreShown {
                    ForEach(salesViewModel.salesByWeekDay, id: \.number) { weekdayData in
                        ForEach(weekdayData.sales) { sale in
                            PointMark(
                                x: .value("Day", weekday(for: weekdayData.number)),
                                y: .value("Sales", sale.quantity)
                            )
                            .opacity(0.3)
                        }
                    }
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .padding(.bottom)
            
            Toggle(individualDaysAreShown ? "Show all daily sales": "Hide daily sales", isOn: $individualDaysAreShown.animation())
            
            Toggle(medianSalesIsSShown ? "Show median sales" : "Hide median sales", isOn: $medianSalesIsSShown.animation())
            
            Spacer()
        }
        .padding()
    }
    
    let formatter = DateFormatter()
    func weekday(for number: Int) -> String {
        formatter.shortWeekdaySymbols[number - 1]
    }
}

#Preview {
    SalesByWeekDayView(
        salesViewModel: .preview
    )
}





