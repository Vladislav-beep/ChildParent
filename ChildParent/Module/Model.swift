//
//  Model.swift
//  ChildParent
//
//  Created by Владислав Сизонов on 18.02.2022.
//

import Foundation

class Model {
    
    var childArray = [Int]()
    
    func clearChildArray() {
        childArray.removeAll()
    }
    
    func countChildren() -> Int {
        return childArray.count
    }
    
    func addChild() {
        childArray.append(1)
    }
    
    func removeChild(at indexPath: Int) {
        childArray.remove(at: indexPath)
    }
}
