//
//  ClearButton.swift
//  ChildParent
//
//  Created by Владислав Сизонов on 18.02.2022.
//

import UIKit

class ClearButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func initialize() {
        
        setTitleColor(.systemRed, for: .normal)
        tintColor = .systemRed
        setTitle("Очистить", for: .normal)
        
        layer.borderWidth = 2.5
        layer.borderColor = UIColor.systemRed.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}
