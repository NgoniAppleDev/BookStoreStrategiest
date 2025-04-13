//
//  DetailExpensesView.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 13/4/2025.
//

import SwiftUI
import Charts

struct DetailExpensesView: View {
    
    enum ChartType {
        case line, bar
    }
    
    @Bindable var expensesViewModel: ExpensesViewModel
    
    @State private var selectedChartType: ChartType = .line
    
    var body: some View {
        List {
            Group {
                Section {
                    Picker("Chart", selection: $selectedChartType.animation()) {
                        Text("Line Chart").tag(ChartType.line)
                        Text("Bar Chart").tag(ChartType.bar)
                    }
                    .pickerStyle(.segmented)
                    .padding(.vertical)
                    
                    switch selectedChartType {
                    case .line:
                        ExpensesLineChartView(expensesViewModel: expensesViewModel)
                    case .bar:
                        ExpensesBarChartView(expensesViewModel: expensesViewModel)
                    }
                }
                
                Section {
                    Text("Detailed Breakdown of Your Expenses per Month")
                        .bold()
                        .padding(.top)
                    
                    ExpensesDetailGridView(expensesViewModel: expensesViewModel)
                }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
        }
        .listStyle(.plain)
    }
}

#Preview {
    DetailExpensesView(
        expensesViewModel: .preview
    )
}














