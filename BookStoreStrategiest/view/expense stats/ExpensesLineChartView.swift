//
//  ExpensesLineChartView.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 13/4/2025.
//

import SwiftUI
import Charts

struct ExpensesLineChartView: View {
    
    @Bindable var expensesViewModel: ExpensesViewModel
    
    var body: some View {
        Chart(expensesViewModel.monthlyExpenseData) { data in
            Plot {
                LineMark(
                    x: .value("Month", data.month),
                    y: .value("Expenses", data.fixedExpenses)
                )
                .foregroundStyle(by: .value("Expenses", "fixed"))
                .symbol(by: .value("Expenses", "fixed"))
                
                LineMark(
                    x: .value("Month", data.month),
                    y: .value("Expenses", data.variableExpenses)
                )
                .foregroundStyle(by: .value("Expenses", "variable"))
                .symbol(by: .value("Expenses", "variable"))
            }
            //            .lineStyle(StrokeStyle(lineWidth: 2))
            .interpolationMethod(.catmullRom)
        }
        .aspectRatio(1, contentMode: .fit)
        .chartForegroundStyleScale(["variable" : .purple, "fixed": .cyan])
        .chartXScale(domain: 0...13)
        .chartXAxis {
            AxisMarks(values: [1, 4, 7, 9, 12]) { value in
                AxisGridLine()
                AxisTick()
                if let number = value.as(Int.self) {
                    AxisValueLabel(month(for: number), anchor: .top)
                }
            }
        }
        .chartYAxis {
            AxisMarks { value in
                AxisGridLine()
                AxisTick()
                if let number = value.as(Double.self) {
                    AxisValueLabel("\(Int(number / 1000)) K")
                }
            }
        }
    }
    
    let formatter = DateFormatter()
    func month(for number: Int) -> String {
        formatter.shortStandaloneMonthSymbols[number - 1]
    }
}

#Preview {
    ExpensesLineChartView(
        expensesViewModel: .preview
    )
    .padding()
}










