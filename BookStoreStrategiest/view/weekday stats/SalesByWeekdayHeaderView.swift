//
//  SalesByWeekdayHeaderView.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 31/3/2025.
//

import SwiftUI

struct SalesByWeekdayHeaderView: View {
    
    @Bindable var salesViewModel: SalesViewModel
    
    var body: some View {
        if let highestSellingWeekday = salesViewModel.highestSellingWeekday {
            Text("Your highest selling day of the week is ") +
            Text("\(weekday(for: highestSellingWeekday.number)) ")
                .bold()
                .foregroundStyle(Color.accentColor) +
            Text("with an average of ") +
            Text("\(Int(highestSellingWeekday.sales)) sales per day.")
                .bold()
        }
    }
    
    let formatter = DateFormatter()
    func weekday(for number: Int) -> String {
        formatter.weekdaySymbols[number - 1]
    }
}

#Preview {
    SalesByWeekdayHeaderView(
        salesViewModel: .preview
    )
}





