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
    var expenses: [Expense] = []
    
    var monthlyExpenseData: [ExpensesStats] = []
    
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




