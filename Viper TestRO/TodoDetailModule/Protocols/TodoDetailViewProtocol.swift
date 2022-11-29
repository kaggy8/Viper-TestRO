//
//  TodoDetailViewProtocol.swift
//  Viper TestRO
//
//  Created by Stanislav Demyanov on 29.11.2022.
//

import UIKit

protocol TodoDetailViewProtocol: AnyObject {
    
    var presenter: TodoDetailPresenterProtocol? { get set }
    
    //PRESENTER -> VIEW
    func showToDo(_ todo: TodoItem)
}

protocol TodoDetailPresenterProtocol: AnyObject {
    var view: TodoDetailViewProtocol? { get set }
    var interactor: TodoDetailInteractorInputProtocol? { get set }
    var router: TodoDetailRouterProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad()
    func editTodo(title: String, content: String)
    func deleteTodo()
}

protocol TodoDetailInteractorInputProtocol: AnyObject {
    var presenter: TodoDetailInteractorOutputProtocol? { get set }
    var todoItem: TodoItem? { get set }
    
    //PRESENTER -> INTERACTOR
    func deleteTodo()
    func editTodo(title: String, content: String)
}

protocol TodoDetailInteractorOutputProtocol: AnyObject {
    
    //INTERACTOR -> PRESENTER
    func didDeleteTodo()
    func didEditTodo(_ todo: TodoItem)
}

protocol TodoDetailRouterProtocol: AnyObject {
static func createTodoDetailRouterModule(with todo: TodoItem) -> UIViewController

//PRESENTER -> ROUTER
func navigateBackToListViewController(from view: TodoDetailViewProtocol)
}
