//
//  SimpleBookSalesView.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 31/3/2025.
//

import SwiftUI

struct SimpleBookSalesView: View {
    @Bindable var salesViewModel: SalesViewModel
    
    var body: some View {
        VStack {
            if let changedBookSales = changedBookSales() {
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: isPositiveChange ? "arrow.up.right": "arrow.down.right")
                        .bold()
                        .foregroundStyle(isPositiveChange ? .green : .red)
                    
                    Text("Your book sales ") +
                    Text(changedBookSales)
                        .bold() +
                    Text(" in the last 90 days.")
                }
            }
            
            WeeklySalesChartView(salesViewModel: salesViewModel)
                .frame(height: 70)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
        }
    }
    
    var percentage: Double {
        let ratio = Double(salesViewModel.totalSales) / Double(salesViewModel.lastTotalSales)
        let change = ratio - 1
        return change
    }
    
    var isPositiveChange: Bool { percentage > 0 }
    
    func changedBookSales() -> String? {
        let percentage = percentage
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
        guard let formattedPercentage = numberFormatter.string(from: NSNumber(value: percentage)) else {
            return nil
        }
        
        let changedDescription = percentage < 0 ? "decreased by " : "increased by "
        
        return changedDescription + formattedPercentage
    }
}

#Preview {
    SimpleBookSalesView(
        salesViewModel: .preview
    )
    .padding()
}

#Preview("negative") {
    let decreasedVM = SalesViewModel.preview
    decreasedVM.lastTotalSales = 1000
    
    return SimpleBookSalesView(
        salesViewModel: decreasedVM
    )
    .padding()
}





