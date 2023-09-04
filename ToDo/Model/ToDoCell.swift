//
//  ToDoCell.swift
//  ToDo
//
//  Created by Александр Корепанов on 06.06.2023.
//
//boss

import UIKit

protocol TodoCellDelegate: AnyObject {
    func didCheckButtonTapped(item: ToDoItem, cell: ToDoCell?)
    
    //можно ли использовать один протокол, но в разных местах только один метод?
}

class ToDoCell: UITableViewCell {
    
    var todoTitleLabel = UILabel()
//    var todoCheckImage = UIImageView()
    var todoCheckButton = UIButton()
    
    var model: ToDoItem?
    
   weak var todoCellDelegate: TodoCellDelegate?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        addSubview(todoCheckImage)
        contentView.addSubview(todoTitleLabel)
        contentView.addSubview(todoCheckButton)
        configureTitleLabel()
        setTitleLabelConstraints()
        configureButton()
        setButtonConstraints()
//        configureImageView()
//        setImageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(item: ToDoItem ) {
        todoTitleLabel.text = item.name
//        вот тут присвоить новой переменной item?
        model = item
        //        todoCheckImage.image = функция которая проверяет какое значение у isDone, если false то uncheck, если true то check
        //        todoCheckImage.image = UIImage(systemName: checkOrNot(isCheck: item.isDone))
        todoCheckButton.setImage(UIImage(systemName: checkOrNot(isCheck: item.isDone)), for: .normal)
    }
    
//    func configureImageView(){
//        todoCheckImage.contentMode = .scaleAspectFit
//        todoCheckImage.clipsToBounds = true
//        todoCheckImage.tintColor = .black
//    }
    
    func configureButton() {
        todoCheckButton.configuration = .plain()
        todoCheckButton.configuration?.buttonSize = .medium
        todoCheckButton.imageView?.contentMode = .scaleAspectFill
        todoCheckButton.configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 35)
//        todoCheckButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        todoCheckButton.configuration?.imagePadding = 0
        
        
//        var configuration = UIButton.Configuration.plain()
////        configuration.imagePadding = 10
////        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 30)
////        configuration.buttonSize = .small
//        todoCheckButton = UIButton(configuration: configuration)
        
        todoCheckButton.addAction(UIAction { [weak self] _ in
            guard let model = self?.model else { return }
            self?.todoCellDelegate?.didCheckButtonTapped(item: model, cell: self)
        }, for: .touchUpInside)
    }
    
    func configureTitleLabel() {
        todoTitleLabel.numberOfLines = 0
        todoTitleLabel.adjustsFontSizeToFitWidth = true
        todoTitleLabel.backgroundColor = .green
        todoTitleLabel.font = todoTitleLabel.font.withSize(20)
    }
    func setTitleLabelConstraints() {
        todoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        todoTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        todoTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        todoTitleLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
//        todoTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100).isActive = true
    }
    
    func setButtonConstraints() {
        todoCheckButton.translatesAutoresizingMaskIntoConstraints = false
        todoCheckButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        todoCheckButton.leadingAnchor.constraint(equalTo: todoTitleLabel.trailingAnchor, constant: 8).isActive = true
        todoCheckButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        todoCheckButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        todoCheckButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        
    }
//    func setImageViewConstraints() {
//        todoCheckImage.translatesAutoresizingMaskIntoConstraints = false
//        todoCheckImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        todoCheckImage.leadingAnchor.constraint(equalTo: todoTitleLabel.trailingAnchor, constant: 50).isActive = true
//        todoCheckImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        todoCheckImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
//    }
    
    func checkOrNot(isCheck: Bool) -> String {
        if isCheck {
            return "checkmark.square"
        } else {
            return "square"
        }
    }
    
}
