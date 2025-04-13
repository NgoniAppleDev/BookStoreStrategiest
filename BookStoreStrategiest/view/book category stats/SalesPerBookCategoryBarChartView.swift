//
//  SalesPerBookCategoryBarChartView.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 12/4/2025.
//

import SwiftUI
import Charts

struct SalesPerBookCategoryBarChartView: View {
    
    @Bindable var salesViewModel: SalesViewModel
    
    var body: some View {
        
        Chart(salesViewModel.totalSalesPerCategory, id: \.category) { data in
            BarMark(
                x:.value("Sales", data.sales),
                y: .value("Book Category", data.category.displayName)
            )
            .annotation(position: .trailing, alignment: .leading) {
                Text("\(data.sales)")
                    .opacity(salesViewModel.bestSellingCategory?.category == data.category ? 1 : 0.3)
            }
            .cornerRadius(5)
            .opacity(salesViewModel.bestSellingCategory?.category == data.category ? 1 : 0.3)
            .foregroundStyle(by: .value("Book Category", data.category.displayName))
        }
        .aspectRatio(1, contentMode: .fit)
        .chartLegend(.hidden)
    }
}

#Preview {
    SalesPerBookCategoryBarChartView(
        salesViewModel: .preview
    )
    .padding()
}







