//
//  SimpleSalesPerBookCategoryView.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 12/4/2025.
//

import SwiftUI
import Charts

struct SimpleSalesPerBookCategoryView: View {
    
    @Bindable var salesViewModel: SalesViewModel
    
    var body: some View {
        HStack {
            SalesPerBookCategoryHeaderView(salesViewModel: salesViewModel)
            
            Chart(salesViewModel.totalSalesPerCategory, id: \.category) { data in
                SectorMark(
                    angle: .value("Book Category", data.sales),
                    innerRadius: .ratio(0.618),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .opacity(salesViewModel.bestSellingCategory?.category == data.category ? 1 : 0.3)
            }
            .aspectRatio(1, contentMode: .fit)
            .frame(height: 90)
        }
    }
}

#Preview {
    SimpleSalesPerBookCategoryView(
        salesViewModel: .preview
    )
    .padding()
}





