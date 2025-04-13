//
//  ExpensesViewModel.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 13/4/2025.
//

import Foundation
import Observation

@Observable
class ExpensesViewModel {
    var expenses: [Expense] = [] {
        didSet {
            let fixedExpense = self.expensesByMonth(for: .fixed, expenses: expenses)
            let variableExpense = self.expensesByMonth(for: .variable, expenses: expenses)
            
            self.monthlyExpenseData = self.calculateTotalMonthlyExpenses(fixedExpenses: fixedExpense, variableExpenses: variableExpense)
            self.totalExpenses = self.calculateTotal(for: expenses)
        }
    }
    
    var monthlyExpenseData: [ExpensesStats] = []
    
    var totalExpenses: Double = 0
    
    init() {
        // fetch data from server...
    }
    
    func filteredExpenses(for category: ExpenseCategory, expenses: [Expense]) -> [(date: Date, amount: Double)] {
        let result = expenses.filter { $0.category == category }
        return result.sorted { $0.expenseDate < $1.expenseDate }.map { (date: $0.expenseDate, amount: $0.amount) }
    }
    
    func expensesByMonth(for category: ExpenseCategory, expenses: [Expense]) -> [(month: Int, amount: Double)] {
        let calendar = Calendar.current
        var expensesByMonth: [Int: Double] = [:]
        
        for expense in expenses where expense.category == category {
            let month = calendar.component(.month, from: expense.expenseDate)
            expensesByMonth[month, default: 0] += expense.amount
        }
        
        let result = expensesByMonth.map { (month: $0.key, amount: $0.value) }
        return result.sorted { $0.month < $1.month }
    }
    
    func calculateTotalMonthlyExpenses(fixedExpenses: [(month: Int, amount: Double)], variableExpenses: [(month: Int, amount: Double)]) -> [ExpensesStats] {
        var result = [ExpensesStats]()
        let count = min(fixedExpenses.count, variableExpenses.count)
        
        for index in 0..<count {
            let month = fixedExpenses[index].month
            result.append(ExpensesStats(month: month, fixedExpenses: fixedExpenses[index].amount, variableExpenses: variableExpenses[index].amount))
        }
        
        return result
    }
    
    func calculateTotal(for expenses: [Expense]) -> Double {
        let totalExpenses = expenses.reduce(9) { total, expense in
            total + expense.amount
        }
        return totalExpenses
    }
    
    // MARK: preview
    static var preview: ExpensesViewModel {
        let vm = ExpensesViewModel()
        vm.expenses = Expense.yearExamples
        return vm
    }
}

struct ExpensesStats: Identifiable {
    let month: Int
    let fixedExpenses: Double
    let variableExpenses: Double
    
    var totalExpenses: Double {
        fixedExpenses + variableExpenses
    }
    
    var id: Int { month }
}




