//
//  ViewController.swift
//  ToDo
//
//  Created by Александр Корепанов on 29.05.2023.
//

import UIKit

class ToDoListScreen: UIViewController {
    
    var tableView = UITableView()
    var toDoList: [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        toDoList = fetchData()
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
//        navigationItem.titleView = createCustomTitleView(titleName: "ToDo List")
//
//        navigationItem.rightBarButtonItem = createAddToDoItemButton(imageName: "plusImage", selector: #selector(addNewToDoItem))
    }
    
//    func createCustomTitleView(titleName: String) -> UIView {
//        let view = UIView()
//        view.frame = CGRect(x: 0, y: 0, width: 320, height: 41)
//
//        let titlelabel = UILabel()
//        titlelabel.text = titleName
//        titlelabel.frame = CGRect(x: 120, y: 50, width: 220, height: 30)
//        titlelabel.font = UIFont.systemFont(ofSize: 20)
//        view.addSubview(titlelabel)
//
//        return view
//    }
//    func createAddToDoItemButton(imageName: String, selector: Selector) -> UIBarButtonItem {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
//        button.imageView?.contentMode = .scaleAspectFit
////        button.contentVerticalAlignment = .fill
////        button.contentHorizontalAlignment = .fill
//        button.addTarget(self, action: selector, for: .touchUpInside)
//
//        let menuBarItem = UIBarButtonItem(customView: button)
//        return menuBarItem
//    }
    
    @objc func addNewToDoItem() {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let textFieldText = textField.text {
                self.toDoList.append(ToDoItem(name: textFieldText, isDone: false))
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}
//extension ToDoListScreen {
//    func fetchData() -> [ToDoItem] {
//
//    }
//}
