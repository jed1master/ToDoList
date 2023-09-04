//
//  ExtendedToDoListScreenViewController.swift
//  ToDo
//
//  Created by Александр Корепанов on 31.07.2023.
//

import UIKit

protocol TodoItemViewDelegate: AnyObject {
    func didBackButtonTapped(item: ToDoItem, todoItemVewController: ToDoItemViewController)
}

class ToDoItemViewController: UIViewController, UITextViewDelegate {
    
    
    
    
    var todoItemTextView = UITextView()
    let todoItem: ToDoItem
    weak var todoItemViewDelegate: TodoItemViewDelegate?
    
    init(todoItem: ToDoItem) {
        self.todoItem = todoItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureTextView()
        setTitleLabelConstraints()
        configureBackAndSaveButton()
    }
    
    
    func configureTextView() {
        view.addSubview(todoItemTextView)
        todoItemTextView.delegate = self
        
        //        todoItemTextView.adjustsFontSizeToFitWidth = true
        //        todoItemLabel.textAlignment = .left
        todoItemTextView.sizeToFit()
        todoItemTextView.text = todoItem.name
        
        todoItemTextView.font = .systemFont(ofSize: 20)
        todoItemTextView.backgroundColor = .orange
        todoItemTextView.isEditable = true
        todoItemTextView.isScrollEnabled = false
    }
    func setTitleLabelConstraints() {
        todoItemTextView.translatesAutoresizingMaskIntoConstraints = false
        //        todoItemLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        //        todoItemLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        //        todoItemLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        //        todoItemLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        //
        todoItemTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        //        todoItemTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        todoItemTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        todoItemTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        todoItemTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    func configureBackAndSaveButton() {
        
        self.navigationItem.hidesBackButton = true
        
        var configuration = UIButton.Configuration.plain()
        configuration.buttonSize = .medium
        configuration.title = "< Back"
        let backAndSaveButton = UIButton(configuration: configuration)
        let leftBarButtonItem = UIBarButtonItem(customView: backAndSaveButton)
        
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        backAndSaveButton.addAction(UIAction { [weak self] _ in
            guard let controller = self,
                  let item = self?.todoItem else { return }
            self?.todoItemViewDelegate?.didBackButtonTapped(item: item, todoItemVewController: controller)
            self?.navigationController?.popViewController(animated: true)
        }, for: .touchUpInside)
        
        //        let backAndSave = UIAction(handler: { [weak self] _ in
        //            //perform action here
        //        })
        //        let backAndSaveButton = UIButton(
        //        navigationItem.leftBarButtonItem = backAndSaveButton
        
        
        
        
    }
    
}
