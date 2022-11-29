//
//  TodoDetailPresenter.swift
//  Viper TestRO
//
//  Created by Stanislav Demyanov on 30.11.2022.
//

import UIKit

class TodoDetailPresenter: TodoDetailPresenterProtocol {
    
    weak var view: TodoDetailViewProtocol?
    var interactor: TodoDetailInteractorInputProtocol?
    var router: TodoDetailRouterProtocol?
    
    func viewDidLoad() {
        if let todoItem = interactor?.todoItem {
            view?.showToDo(todoItem)
        }
    }
    
    func editTodo(title: String, content: String) {
        interactor?.editTodo(title: title, content: content)
    }
    
    func deleteTodo() {
        interactor?.deleteTodo()
    }
}

extension TodoDetailPresenter: TodoDetailInteractorOutputProtocol {
    func didDeleteTodo() {
        if let view = view {
            router?.navigateBackToListViewController(from: view)
        }
    }
    
    func didEditTodo(_ todo: TodoItem) {
        view?.showToDo(todo)
    }
}
