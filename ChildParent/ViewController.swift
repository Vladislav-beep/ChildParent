//
//  ViewController.swift
//  ChildParent
//
//  Created by Владислав Сизонов on 17.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var nameView: CustomView = {
        let view = CustomView(labelText: "Имя")
        return view
    }()
    
    private lazy var ageView: CustomView = {
        let view = CustomView(labelText: "Возраст")
        return view
    }()
    
    private lazy var nameAndAgeStack: UIStackView = {
        let nameAndAgeStack = UIStackView(arrangedSubviews: [nameView, ageView])
        nameAndAgeStack.distribution = .fillEqually
        nameAndAgeStack.axis = .vertical
        nameAndAgeStack.spacing = 10
        nameAndAgeStack.translatesAutoresizingMaskIntoConstraints = false
        return nameAndAgeStack
    }()
    
    private lazy var personalLabel: UILabel = {
        let personalLabel = UILabel()
        personalLabel.text = "Персональные данные"
        personalLabel.translatesAutoresizingMaskIntoConstraints = false
        return personalLabel
    }()
    
    private lazy var childrenLabel: UILabel = {
        let childrenLabel = UILabel()
        childrenLabel.text = "Дeти (макс.5)"
        childrenLabel.font = UIFont.systemFont(ofSize: 18)
        childrenLabel.translatesAutoresizingMaskIntoConstraints = false
        return childrenLabel
    }()
    
    private lazy var addChildButton: AddChildButton = {
        let addChildButton = AddChildButton()
        return addChildButton
    }()

    private lazy var childButtonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [childrenLabel, addChildButton])
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAllConstraints()
    }
    
    private func setupAllConstraints() {
        setupPersonalLabelConstraints()
        setupNameAndAgeStackConstraints()
        setupChildButtonStack()
    }
    
    private func setupPersonalLabelConstraints() {
        view.addSubview(personalLabel)
        NSLayoutConstraint.activate([
            personalLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            personalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            personalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            personalLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupNameAndAgeStackConstraints() {
        view.addSubview(nameAndAgeStack)
        NSLayoutConstraint.activate([
            nameAndAgeStack.topAnchor.constraint(equalTo: personalLabel.bottomAnchor, constant: 20),
            nameAndAgeStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            nameAndAgeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            nameAndAgeStack.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    private func setupChildButtonStack() {
        view.addSubview(childButtonStack)
        NSLayoutConstraint.activate([
            childButtonStack.topAnchor.constraint(equalTo: nameAndAgeStack.bottomAnchor, constant: 10),
            childButtonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            childButtonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            childButtonStack.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}

