//
//  TodoDetailRouter.swift
//  Viper TestRO
//
//  Created by Stanislav Demyanov on 30.11.2022.
//

import UIKit

class TodoDetailRouter: TodoDetailRouterProtocol {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func navigateBackToListViewController(from view: TodoDetailViewProtocol) {
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid View Protocol Type")
        }
        viewVC.navigationController?.popViewController(animated: true)
    }
    
    static func createTodoDetailRouterModule(with todo: TodoItem) -> UIViewController {
        
        guard let todoDetailVC = storyboard.instantiateViewController(withIdentifier: "TodoDetailViewController") as? TodoDetailViewController else {
            fatalError("Invalid View Protocol Type")
        }
        
        let presenter: TodoDetailPresenter & TodoDetailInteractorOutputProtocol = TodoDetailPresenter()
        todoDetailVC.presenter = presenter
        presenter.view = todoDetailVC
        let interactor: TodoDetailInteractorInputProtocol = TodoDetailInteractor()
        interactor.todoItem = todo
        interactor.presenter = presenter
        presenter.interactor = interactor
        let router: TodoDetailRouterProtocol = TodoDetailRouter()
        presenter.router = router
        
        return todoDetailVC
    }
}
