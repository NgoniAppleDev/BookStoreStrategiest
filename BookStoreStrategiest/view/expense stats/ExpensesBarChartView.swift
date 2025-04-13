//
//  ExpensesBarChartView.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 13/4/2025.
//

import SwiftUI
import Charts

struct ExpensesBarChartView: View {
    @Bindable var expensesViewModel: ExpensesViewModel
    
    var body: some View {
        Chart(expensesViewModel.monthlyExpenseData) { data in
            Plot {
                BarMark(
                    x: .value("Month", month(for: data.month)),
                    y: .value("Expenses", data.fixedExpenses)
                )
                .foregroundStyle(by: .value("Expenses", "fixed"))
                .position(by: .value("Expenses", "fixed"))
                
                BarMark(
                    x: .value("Month", month(for: data.month)),
                    y: .value("Expenses", data.variableExpenses)
                )
                .foregroundStyle(by: .value("Expenses", "variable"))
                .position(by: .value("Expenses", "variable"))
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    let formatter = DateFormatter()
    func month(for number: Int) -> String {
        formatter.shortStandaloneMonthSymbols[number - 1]
    }
}

#Preview {
    ExpensesBarChartView(
        expensesViewModel: .preview
    )
    .padding()
}






