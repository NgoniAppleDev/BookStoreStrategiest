//
//  SalesViewModel.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 30/3/2025.
//

import Foundation
import Observation

@Observable
class SalesViewModel {
    var salesData: [Sale] = []
    
    var totalSales: Int {
        self.salesData.reduce(0) { $0 + $1.quantity }
    }
    
    var lastTotalSales: Int = 0
    
    var salesByWeek: [(day: Date, sales: Int)] {
        totalSalesPerDate(salesByDate: salesGroupedByWeek(sales: salesData))
    }
    
    init() {
        // fetch the data from e.g. server
    }
    
//    func salesGroupedByWeek(sales: [Sale]) -> [Date: [Sale]] {
//        var salesByWeek: [Date: [Sale]] = [:]
//        let calendar = Calendar.current
//        
//        for sale in sales {
//            guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: sale.saleDate)) else { continue }
//            if salesByWeek[startOfWeek] != nil {
//                salesByWeek[startOfWeek]!.append(sale)
//            } else {
//                salesByWeek[startOfWeek] = [sale]
//            }
//        }
//        
//        return salesByWeek
//    }
    
    func totalSalesPerDate(salesByDate: [Date: [Sale]]) -> [(day: Date, sales: Int)] {
        var totalSales: [(day: Date, sales: Int)] = []
        
        for (date, sales) in salesByDate {
            let totalQuantityForDate = sales.reduce(0) { $0 + $1.quantity }
            totalSales.append((day: date, sales: totalQuantityForDate))
        }
        
        return totalSales
    }
    
    func salesGroupedByWeek(sales: [Sale]) -> [Date: [Sale]] {
        var salesByWeek: [Date: [Sale]] = [:]
        let calendar = Calendar.current
        
        salesByWeek = Dictionary(grouping: self.salesData) { sale in
            calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: sale.saleDate))!
        }
        
        return salesByWeek
    }
    
    static var preview: SalesViewModel {
        let vm = SalesViewModel()
        vm.salesData = Sale.threeMonthsExamples()
        vm.lastTotalSales = 1200
        
        return vm
    }
}
