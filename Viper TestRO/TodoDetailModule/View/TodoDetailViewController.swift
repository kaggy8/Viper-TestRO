//
//  TodoDetailViewController.swift
//  Viper TestRO
//
//  Created by Stanislav Demyanov on 29.11.2022.
//

import UIKit

class TodoDetailViewController: UIViewController {
   
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    
    var presenter: TodoDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    @IBAction func deleteTapped(_ sender: UIBarButtonItem) {
        presenter?.deleteTodo()
    }
    
    @IBAction func editTodo(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Edit Todo Item", message: "Enter title and content", preferredStyle: .alert)
        alertController.addTextField { $0.text = self.titleLabel.text }
        alertController.addTextField { $0.text = self.contentLabel.text }
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { [weak self] (_) in
            let titleText = alertController.textFields![0].text ?? ""
            let contentText = alertController.textFields![1].text ?? ""
            
            guard !titleText.isEmpty else { return }
            self?.presenter?.editTodo(title: titleText, content: contentText)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}

extension TodoDetailViewController: TodoDetailViewProtocol {
    
    func showToDo(_ todo: TodoItem) {
        titleLabel.text = todo.title
        contentLabel.text = todo.content
    }
}
