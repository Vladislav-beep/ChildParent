//
//  addChildButton.swift
//  ChildParent
//
//  Created by Владислав Сизонов on 17.02.2022.
//

import UIKit

class AddChildButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func initialize() {
        
        setTitleColor(.systemBlue, for: .normal)
        tintColor = .systemBlue
        setTitle("  Добавить ребенка", for: .normal)
        setImage(UIImage(systemName: "plus"), for: .normal)
        
        layer.borderWidth = 2.5
        layer.borderColor = UIColor.systemBlue.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}


