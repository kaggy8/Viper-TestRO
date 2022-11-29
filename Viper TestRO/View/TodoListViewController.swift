//
//  TodoListViewController.swift
//  Viper TestRO
//
//  Created by Stanislav Demyanov on 28.11.2022.
//

import UIKit

class TodoListViewController: UITableViewController {

    var presenter: TodoListPresenterProtocol?
    var todos: [TodoItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }
    
    private func setupView() {
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let todo = todos[indexPath.row]
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = todo.title
            content.secondaryText = todo.content

            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = todo.title
            cell.detailTextLabel?.text = todo.content
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todos[indexPath.row]
        presenter?.showTodoDetail(todo)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todoItem = todos[indexPath.row]
            presenter?.removeTodo(todoItem)
        }
    }
    
    @IBAction func addTodo(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Todo Item", message: "Enter title and content", preferredStyle: .alert)
        
        alertController.addTextField()
        alertController.addTextField()
        
        let action = UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
            guard let titleText = alertController.textFields?[0].text else { return }
            guard let contentText = alertController.textFields?[1].text else { return }
            
            let todoItem = TodoItem(title: titleText, content: contentText)
            self?.presenter?.addTodo(todoItem)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(action)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}

extension TodoListViewController: TodoListViewProtocol {
    func showTodos(_ todos: [TodoItem]) {
        self.todos = todos
    }
    
    func showErrorMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}
