//
//  ViewController.swift
//  ChildParent
//
//  Created by Владислав Сизонов on 17.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var model = Model()
    
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
        addChildButton.addTarget(self, action: #selector(addRow), for: .touchUpInside)
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
    
    private lazy var childrenTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.isHidden = true
        table.register(ChildCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var clearButton: ClearButton = {
        let clearButton = ClearButton()
        clearButton.addTarget(self, action: #selector(deleteAllChildren), for: .touchUpInside)
        return clearButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAllConstraints()
        setupChildTable()
    }
    
    @objc func addRow() {
        if model.countChildren() < 5 {
            model.addChild()
            setupChildTable()
            childrenTable.beginUpdates()
            childrenTable.insertRows(at: [IndexPath(row: model.countChildren() - 1, section: 0)],
                                     with: .automatic)
            childrenTable.endUpdates()
        }
    }
    
    @objc func deleteAllChildren() {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let delete = UIAlertAction(title: "Очистить", style: .default) { [weak self] _ in
            self?.model.clearChildArray()
            self?.setupChildTable()
            self?.childrenTable.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        actionSheet.addAction(delete)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
    
    private func setupChildTable() {
        if model.countChildren() > 0 {
            childrenTable.isHidden = false
        } else {
            childrenTable.isHidden = true
        }
    }
    
    private func setupAllConstraints() {
        setupPersonalLabelConstraints()
        setupNameAndAgeStackConstraints()
        setupChildButtonStack()
        setupClearButtonConstraints()
        setuptableViewConstraints()
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
    
    private func setupClearButtonConstraints() {
        view.addSubview(clearButton)
        NSLayoutConstraint.activate([
            clearButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            clearButton.heightAnchor.constraint(equalToConstant: 45),
            clearButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setuptableViewConstraints() {
        view.addSubview(childrenTable)
        NSLayoutConstraint.activate([
            childrenTable.topAnchor.constraint(equalTo: childButtonStack.bottomAnchor, constant: 10),
            childrenTable.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -20),
            childrenTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            childrenTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.countChildren()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ChildCell else { return UITableViewCell() }
        
        cell.didDelete = { [weak self] in
            self?.model.removeChild(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self?.childrenTable.reloadData()
            self?.setupChildTable()
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
}

