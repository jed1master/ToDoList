//
//  ToDoCell.swift
//  ToDo
//
//  Created by Александр Корепанов on 06.06.2023.
//

import UIKit

class ToDoCell: UITableViewCell {
    
    var todoTitleLabel = UILabel()
//    var todoCheckImage = UIImageView()
    var todoCheckButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(todoTitleLabel)
//        addSubview(todoCheckImage)
        addSubview(todoCheckButton)
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
        todoCheckButton.setTitle("", for: .normal)
    }
    
    func configureTitleLabel() {
        todoTitleLabel.numberOfLines = 0
        todoTitleLabel.adjustsFontSizeToFitWidth = true
    }
    func setTitleLabelConstraints() {
        todoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        todoTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        todoTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        todoTitleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        todoTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100).isActive = true
    }
    
    func setButtonConstraints() {
        todoCheckButton.translatesAutoresizingMaskIntoConstraints = false
        todoCheckButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        todoCheckButton.leadingAnchor.constraint(equalTo: todoTitleLabel.trailingAnchor, constant: 50).isActive = true
        todoCheckButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        todoCheckButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
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
