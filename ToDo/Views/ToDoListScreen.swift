//
//  ViewController.swift
//  ToDo
//
//  Created by Александр Корепанов on 29.05.2023.
//
//delegate

import UIKit

class ToDoListScreen: UIViewController {
    
    
    var tableView = UITableView()
    var toDoList: [ToDoItem] = []
    let manager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoList = manager.loadData()
        configureTableView()
        setupNavigationBar()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        //set delegates
        setTableViewDelegates()
        
        //set row height
        tableView.rowHeight = 50
        
        //register cells
        tableView.register(ToDoCell.self, forCellReuseIdentifier: "ToDoCell")
        
        //set constraints
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupNavigationBar() {
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addNewToDoItem))
        navigationItem.title = "ToDo List"
    }
    
    @objc func addNewToDoItem() {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let textFieldText = textField.text {
                self.toDoList.append(ToDoItem(name: textFieldText, isDone: false))
                self.manager.saveData(myArray: self.toDoList)
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
}

extension ToDoListScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as! ToDoCell
        let todoItem = toDoList[indexPath.row]
        cell.set(item: todoItem)
        cell.todoCellDelegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        _ = tableView.cellForRow(at: indexPath) as! ToDoCell
        
        
        //        var todoItem = toDoList[indexPath.row]
        //        todoItem.isDone = todoItem.isDone == false
        //        toDoList[indexPath.row] = todoItem
        //        cell.set(item: todoItem)
        //        manager.saveData(myArray: toDoList)
        let todoItem = toDoList[indexPath.row]
        
        let nextScreen = ToDoItemViewController(todoItem: todoItem)
        nextScreen.todoItemViewDelegate = self
        nextScreen.title = "ToDoList Editing"
        self.navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            manager.saveData(myArray: toDoList)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

extension ToDoListScreen: TodoCellDelegate {
    
    func didCheckButtonTapped(item: ToDoItem, cell: ToDoCell?) {
        var newItem = item
        //        var todoItem = toDoList[indexPath.row]
        //        todoItem.isDone = todoItem.isDone == false
        //        toDoList[indexPath.row] = todoItem
        //        cell.set(item: todoItem)
        //        manager.saveData(myArray: toDoList)
        newItem.isDone = newItem.isDone == false
        if let index = self.toDoList.firstIndex(where: { $0.id == item.id } ) {
            toDoList[index] = newItem
            cell?.set(item: newItem)
            manager.saveData(myArray: toDoList)
        }
    }
}

extension ToDoListScreen: TodoItemViewDelegate {
    func didBackButtonTapped(item: ToDoItem, todoItemVewController: ToDoItemViewController) {
        var newItem = item
        newItem.name = todoItemVewController.todoItemTextView.text
        if let index = self.toDoList.firstIndex(where: {$0.id == item.id}) {
            toDoList[index] = newItem
            manager.saveData(myArray: toDoList)
            self.tableView.reloadData()
        }
    }
}
