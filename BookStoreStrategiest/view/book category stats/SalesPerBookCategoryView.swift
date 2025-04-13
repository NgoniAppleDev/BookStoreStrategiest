//
//  SalesPerBookCategoryView.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 12/4/2025.
//

import SwiftUI

struct SalesPerBookCategoryView: View {
    
    enum ChartStyle: CaseIterable, Identifiable {
        case pie, bar
        
        var id: Self { self }
        
        var displayName: String {
            switch self {
            case .pie:
                "Pie Chart"
            case .bar:
                "Bar Chart"
            }
        }
    }
    
    @Bindable var salesViewModel: SalesViewModel
    @State private var selectedChartType: ChartStyle = .pie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Picker("Chart Type", selection: $selectedChartType.animation()) {
                ForEach(ChartStyle.allCases) {
                    Text($0.displayName)
                }
            }
            .pickerStyle(.segmented)
            
            SalesByWeekdayHeaderView(salesViewModel: salesViewModel)
            
            switch selectedChartType {
            case .pie:
                SalesPerBookCategoryPieChartView(salesViewModel: salesViewModel)
            case .bar:
                SalesPerBookCategoryBarChartView(salesViewModel: salesViewModel)
            }
            
            Button {
                withAnimation(.bouncy) {
                    salesViewModel.fetchSalesData()
                }
            } label: {
                Label("Refresh", systemImage: "arrow.triangle.2.circlepath")
            }
            .frame(maxWidth: .infinity)
            .padding(30)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SalesPerBookCategoryView(
        salesViewModel: .preview
    )
}







