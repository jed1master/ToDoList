//
//  ToDoCell.swift
//  ToDo
//
//  Created by Александр Корепанов on 06.06.2023.
//

import UIKit

class ToDoCell: UITableViewCell {
    
    var todoTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(todoTitleLabel)
        configureTitleLabel()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(item: ToDoItem ) {
        todoTitleLabel.text = item.name
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
    
    
}
