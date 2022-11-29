//
//  TodoDetailInteractor.swift
//  Viper TestRO
//
//  Created by Stanislav Demyanov on 30.11.2022.
//

import Foundation

class TodoDetailInteractor: TodoDetailInteractorInputProtocol {
    
    weak var presenter: TodoDetailInteractorOutputProtocol?
    var todoStore = TodoStore.shared
    var todoItem: TodoItem?
    
    func deleteTodo() {
        guard let todoItem = todoItem else { return }
        todoStore.removeTodo(todoItem)
        presenter?.didDeleteTodo()
    }
    
    func editTodo(title: String, content: String) {
        guard let todoItem = todoItem else { return }
        todoItem.title = title
        todoItem.content = content
        presenter?.didEditTodo(todoItem)
    }
}
