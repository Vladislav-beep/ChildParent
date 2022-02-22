//
//  ViewController.swift
//  ChildParent
//
//  Created by Владислав Сизонов on 17.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Dependencies
    
    var model = Model()
    
    // MARK: UI
    
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
        childrenLabel.font = UIFont.systemFont(ofSize: 17)
        childrenLabel.translatesAutoresizingMaskIntoConstraints = false
        return childrenLabel
    }()
    
    private lazy var addChildButton: AddChildButton = {
        let addChildButton = AddChildButton()
        addChildButton.addTarget(self, action: #selector(addRow), for: .touchUpInside)
        return addChildButton
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
    
    // MARK: Life Time
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAllConstraints()
        setupChildTable()
    }
    
    // MARK: Actions
    
    @objc func addRow() {
        if model.countChildren() < 5 {
            model.addChild()
            setupAddChildButton()
            setupChildTable()
            childrenTable.beginUpdates()
            childrenTable.insertRows(at: [IndexPath(row: 0, section: 0)],
                                     with: .automatic)
            childrenTable.endUpdates()
        }
    }
    
    @objc func deleteAllChildren() {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let delete = UIAlertAction(title: "Сбросить данные", style: .default) { [weak self] _ in
            self?.model.clearChildArray()
            self?.setupChildTable()
            self?.setupAddChildButton()
            self?.childrenTable.reloadData()
            self?.clearTextFields()
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        actionSheet.addAction(delete)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
    
    // MARK: Private methods
    
    private func clearTextFields() {
        nameView.textField.text = ""
        ageView.textField.text = ""
    }
    
    private func setupAddChildButton() {
        if model.countChildren() < 5 {
            addChildButton.isHidden = false
        } else {
            addChildButton.isHidden = true
        }
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
        setupChildrenLabelConstraints()
        setupAddChildButtonConstraints()
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
    
    private func setupChildrenLabelConstraints() {
        view.addSubview(childrenLabel)
        NSLayoutConstraint.activate([
            childrenLabel.topAnchor.constraint(equalTo: nameAndAgeStack.bottomAnchor, constant: 10),
            childrenLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            childrenLabel.heightAnchor.constraint(equalToConstant: 45),
            childrenLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupAddChildButtonConstraints() {
        view.addSubview(addChildButton)
        NSLayoutConstraint.activate([
            addChildButton.centerYAnchor.constraint(equalTo: childrenLabel.centerYAnchor, constant: 0),
            addChildButton.leadingAnchor.constraint(equalTo: childrenLabel.trailingAnchor, constant: 10),
            addChildButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            addChildButton.heightAnchor.constraint(equalToConstant: 45)
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
            childrenTable.topAnchor.constraint(equalTo: childrenLabel.bottomAnchor, constant: 10),
            childrenTable.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -20),
            childrenTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            childrenTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
}

// MARK: UITableViewDataSource

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
            self?.setupAddChildButton()
            cell.nameView.textField.text = ""
            cell.ageView.textField.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
}

