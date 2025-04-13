//
//  ExpensesDetailGridView.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 13/4/2025.
//

import SwiftUI

struct ExpensesDetailGridView: View {
    
    @Bindable var expensesViewModel: ExpensesViewModel
    
    var body: some View {
        Grid(alignment: .trailing, horizontalSpacing: 15, verticalSpacing: 10) {
            
            GridRow {
                Color.clear
                    .gridCellUnsizedAxes([.horizontal, .vertical])
                
                Text("Fixed")
                Text("Variable")
                Text("All")
            }
            .gridCellAnchor(.center)
            .bold()
            
            Divider()
            
            ForEach(expensesViewModel.monthlyExpenseData) { data in
                
                GridRow {
                    Text(month(for: data.month))
                    
                    Text("$\(formatNumber(data.fixedExpenses))")
                    Text("$\(formatNumber(data.variableExpenses))")
                    Text("$\(formatNumber(data.totalExpenses))")
                }
                
            }
            
            Divider()
            
            GridRow {
                Text("Total")
                    .bold()
                
                Color.clear
                    .gridCellUnsizedAxes([.horizontal, .vertical])
                    .gridCellColumns(2)
                
                Text("$\(formatNumber(expensesViewModel.totalExpenses))")
                    .bold()
                    .foregroundStyle(.pink)
            }
        }
    }
    
    let formatter = DateFormatter()
    func month(for number: Int) -> String {
        formatter.shortStandaloneMonthSymbols[number - 1]
    }
    
    func formatNumber(_ value: Double) -> String {
        let absValue = abs(value)
        let sign = value < 0 ? "-" : ""

        switch absValue {
        case 1_000_000_000...:
            return "\(sign)\(roundToOneDecimal(absValue / 1_000_000_000))B"
        case 1_000_000...:
            return "\(sign)\(roundToOneDecimal(absValue / 1_000_000))M"
        case 1_000...:
            return "\(sign)\(roundToOneDecimal(absValue / 1_000))K"
        default:
            return "\(sign)\(Int(absValue))"
        }
    }

    private func roundToOneDecimal(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}

#Preview {
    ExpensesDetailGridView(
        expensesViewModel: .preview
    )
}










