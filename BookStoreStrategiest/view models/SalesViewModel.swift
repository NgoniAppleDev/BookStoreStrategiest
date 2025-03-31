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
    
    var highestSellingWeekday: (number: Int, sales: Double)? {
        averageSalesByWeekday.max(by: { $0.sales < $1.sales })
    }
    
    var averageSalesByWeekday: [(number: Int, sales: Double)] {
        let salesByWeekday = salesGroupedByWeekday(sales: salesData)
        let averageSales = averageSalesPerNumber(salesByNumber: salesByWeekday)
        let sorted = averageSales.sorted { $0.number < $1.number }
        
        return sorted
    }
    
    var salesByWeekDay: [(number: Int, sales: [Sale])] {
        let salesByWeekday = salesGroupedByWeekday(sales: salesData).map {
            (number:$0.key, sales: $0.value)
        }
        
        return salesByWeekday.sorted { $0.number < $1.number }
    }
    
    var medianSales: Double {
        let salesData = self.averageSalesByWeekday
        return calculateMedian(salesData: salesData) ?? 0
    }
    
    init() {
        // fetch the data from e.g. server
    }
        
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
    
    func salesGroupedByWeekday(sales: [Sale]) -> [Int: [Sale]] {
        var salesByWeekday: [Int: [Sale]] = [:]
        let calendar = Calendar.current
        
        salesByWeekday = Dictionary(grouping: sales, by: { sale in
            calendar.component(.weekday, from: sale.saleDate)
        })
        
        return salesByWeekday
    }
    
    func averageSalesPerNumber(salesByNumber: [Int: [Sale]]) -> [(number: Int, sales: Double)] {
        var averagesSales: [(number: Int, sales: Double)] = []
        
        for (number, sales) in salesByNumber {
            let count = sales.count
            let totalQuantityForWeekday = sales.reduce(0) { $0 + $1.quantity }
            averagesSales.append((number: number, sales: Double(totalQuantityForWeekday) / Double(count)))
        }
        
        return averagesSales
    }
    
    func calculateMedian(salesData: [(number: Int, sales: Double)]) -> Double? {
        let quantities = salesData.map { $0.sales }.sorted()
        let count = quantities.count
        
        if count % 2 == 0 {
            // Even count: the median is the average of the two middle numbers
            let middleIndex = count / 2
            let median = (quantities[middleIndex - 1] + quantities[middleIndex]) / 2
            return Double(median)
        } else {
            // Odd count: the median is the middle number
            let middleIndex = count / 2
            return Double(quantities[middleIndex])
        }
    }
    
    static var preview: SalesViewModel {
        let vm = SalesViewModel()
        vm.salesData = Sale.higherWeekendThreeMonthsExamples
        vm.lastTotalSales = 500
        
        return vm
    }
    
    ///    func salesGroupedByWeek(sales: [Sale]) -> [Date: [Sale]] {
    ///        var salesByWeek: [Date: [Sale]] = [:]
    ///        let calendar = Calendar.current
    ///
    ///        for sale in sales {
    ///            guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: sale.saleDate)) else { continue }
    ///            if salesByWeek[startOfWeek] != nil {
    ///                salesByWeek[startOfWeek]!.append(sale)
    ///            } else {
    ///                salesByWeek[startOfWeek] = [sale]
    ///            }
    ///        }
    ///
    ///        return salesByWeek
    ///    }

    ///    func salesGroupedByWeekday(sales: [Sale]) -> [Int: [Sale]] {
///        var salesByWeekday: [Int: [Sale]] = [:]
///        let calendar = Calendar.current
///
///        for sale in sales {
///            let weekday = calendar.component(.weekday, from: sale.saleDate)
///            if salesByWeekday[weekday] != nil {
///                salesByWeekday[weekday]?.append(sale)
///            } else {
///                salesByWeekday[weekday] = [sale]
///            }
///        }
///
///        return salesByWeekDay
///    }

}












