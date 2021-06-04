//
//  Card.swift
//  Concentration
//
//  Created by xenon on 2021/5/24.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    
    var isMatched = false
    
    var identifier: Int
    
    private static var identiferFactory = 0
    
    private static func getUniqueIdentifer() -> Int {
        identiferFactory += 1
        return identiferFactory
    }
    
    // 上层的Concentration不关心identifer，所以identifier的初始化应当由Card自己进行，这个一个很好的解耦合方法
    init() {
        self.identifier = Card.getUniqueIdentifer()
    }
    
}
