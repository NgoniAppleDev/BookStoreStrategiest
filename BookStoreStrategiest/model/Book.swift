//
//  Book.swift
//  BookStoreStrategiest
//
//  Created by Ngoni Katsidzira  on 29/3/2025.
//

import Foundation

struct Book: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let author: Author
    let category: BookCategory
    let price: Double
    let inventoryCount: Int
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        lhs.id == rhs.id
    }
    
    static var example = Book (
        title: "Harry Potter and the Sorcerer's Stone",
        author: Author.examples[0],
        category: .fiction,
        price: 19.99,
        inventoryCount: 100
    )
    
    static var examples: [Book] = [
        Book(
            title: "Harry Potter and the Sorcerer's Stone",
            author: Author.examples[0],
            category: .fiction,
            price: 19.99,
            inventoryCount: 100
        ),
        Book(
            title: "The Lord of the Rings",
            author: Author.examples[1],
            category: .fiction,
            price: 25.99,
            inventoryCount: 85
        ),
        Book(
            title: "To Kill a Mockingbird",
            author: Author.examples[2],
            category: .fiction,
            price: 15.99,
            inventoryCount: 70
        ),
    ]
}
