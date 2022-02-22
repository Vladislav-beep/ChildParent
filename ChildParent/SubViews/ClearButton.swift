//
//  ClearButton.swift
//  ChildParent
//
//  Created by Владислав Сизонов on 18.02.2022.
//

import UIKit

class ClearButton: UIButton {
    
    // MARK: Life Time
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
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
}
