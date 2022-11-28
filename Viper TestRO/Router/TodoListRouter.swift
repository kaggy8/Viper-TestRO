//
//  TodoListRouter.swift
//  Viper TestRO
//
//  Created by Stanislav Demyanov on 29.11.2022.
//

import UIKit

class TodoListRouter: TodoListRouterProtocol {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createTodoListModule() -> UIViewController {
        let navController = storyboard.instantiateViewController(withIdentifier: "TodoListNavigation") as! UINavigationController
        guard let todoListVC = navController.topViewController as? TodoListViewController else {
            fatalError("Invalid View Controller")
        }
        
        let presenter: TodoListPresenterProtocol & TodoListInteractorOutputProtocol = TodoListPresenter()
        let interactor: TodoListInteractorInputProtocol = TodoListInteractor()
        let router = TodoListRouter()
        
        todoListVC.presenter = presenter
        presenter.view = todoListVC
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return navController
    }
    
    func presentTodoDetailsScreen(from view: TodoListViewProtocol, for todo: TodoItem) {
//        let todoDetailVC = TodoDetailRouter.createTodoDetailRouterModule(with: todo)
//
//        guard let viewVC = view as? UIViewController else {
//            fatalError("Invalid View Protocol type")
//        }
//
//        viewVC.navigationController?.pushViewController(todoDetailVC, animated: true)
    }
}
