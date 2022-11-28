//
//  TodoListPresenter.swift
//  Viper TestRO
//
//  Created by Stanislav Demyanov on 28.11.2022.
//

import UIKit

class TodoListPresenter: TodoListPresenterProtocol {
    
    var view: TodoListViewProtocol?
    var interactor: TodoListInteractorInputProtocol?
    var router: TodoListRouterProtocol?
    
    func viewWillAppear() {
        interactor?.retrieveTodos()
    }
    
    func showTodoDetail(_ todo: TodoItem) {
        guard let view = view else { return }
        router?.presentTodoDetailsScreen(from: view, for: todo)
    }
    
    func addTodo(_ todo: TodoItem) {
        interactor?.saveTodo(todo)
    }
    
    func removeTodo(_ todo: TodoItem) {
        interactor?.deleteTodo(todo)
    }
}

extension TodoListPresenter: TodoListInteractorOutputProtocol {
    func didAddTodo(_ todo: TodoItem) {
        interactor?.retrieveTodos()
    }
    
    func didRemoveTodo(_ todo: TodoItem) {
        interactor?.retrieveTodos()
    }
    
    func didRetrieveTodos(_ todos: [TodoItem]) {
        view?.showTodos(todos)
    }
    
    func onError(message: String) {
        view?.showErrorMessage(message)
    }
}
