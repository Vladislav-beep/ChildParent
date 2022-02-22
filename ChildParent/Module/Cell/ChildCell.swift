//
//  ChildCell.swift
//  ChildParent
//
//  Created by Владислав Сизонов on 18.02.2022.
//

import UIKit

class ChildCell: UITableViewCell {
    
    // MARK: Properties
    
    @objc var didDelete: () -> () = {}
    
    // MARK: UI
    
    lazy var nameView: CustomView = {
        let view = CustomView(labelText: "Имя")
        return view
    }()
    
    lazy var ageView: CustomView = {
        let view = CustomView(labelText: "Возраст")
        return view
    }()
    
    private lazy var nameAndAgeStack: UIStackView = {
        let nameAndAgeStack = UIStackView(arrangedSubviews: [nameView, ageView])
        nameAndAgeStack.distribution = .fillEqually
        nameAndAgeStack.axis = .vertical
        nameAndAgeStack.spacing = 16
        nameAndAgeStack.translatesAutoresizingMaskIntoConstraints = false
        return nameAndAgeStack
    }()
    
    private lazy var deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.setTitleColor(.systemBlue, for: .normal)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        return deleteButton
    }()
    
    // MARK: Life Time
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackConstraints()
        setupDeleteButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    @objc func didTapDelete() {
        didDelete()
    }
    
    // MARK: Private methods
    
    private func setupStackConstraints() {
        contentView.addSubview(nameAndAgeStack)
        NSLayoutConstraint.activate([
            nameAndAgeStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameAndAgeStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            nameAndAgeStack.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2),
            nameAndAgeStack.heightAnchor.constraint(equalToConstant: 135)
        ])
    }
    
    private func setupDeleteButtonConstraints() {
        contentView.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.centerYAnchor.constraint(equalTo: nameView.centerYAnchor, constant: 0),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            deleteButton.widthAnchor.constraint(equalToConstant: 70),
            deleteButton.leadingAnchor.constraint(equalTo: nameAndAgeStack.trailingAnchor, constant: 20)
        ])
    }
    
}
