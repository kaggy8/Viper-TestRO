//
//  TodoStore.swift
//  Viper TestRO
//
//  Created by Stanislav Demyanov on 28.11.2022.
//

import Foundation

class TodoStore {
    public static let shared = TodoStore()
    
    public private(set) var todos: [TodoItem] = [
        TodoItem(title: "Focus", content: "Decide on what you want to focus in your life"),
        TodoItem(title: "Value", content: "Decide on what values are meaningful in your life"),
        TodoItem(title: "Action", content: "Decide on what you should do to achieve empowering life")
    ]
    
    func addTodo(_ todo: TodoItem) {
        todos.append(todo)
    }
    
    func removeTodo(_ todo: TodoItem) {
        if let index = todos.firstIndex(where: { $0 === todo }) {
            todos.remove(at: index)
        }
    }
    
    private init() {}
}
