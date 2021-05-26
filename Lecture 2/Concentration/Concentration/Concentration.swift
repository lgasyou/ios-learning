//
//  Concentration.swift
//  Concentration
//
//  Created by xenon on 2021/5/24.
//

import Foundation

// MVC中的Model
// 课程中提到，重构时以可以重新运行无误为第一个标准，之后再添加新的特性
class Concentration {
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if (cards[index].isMatched || indexOfOneAndOnlyFaceUpCard == index) {
            return
        }
        
        // 已经点击了一个卡片
        if (indexOfOneAndOnlyFaceUpCard != nil) {
            let matchIndex = indexOfOneAndOnlyFaceUpCard!
            // 当卡片匹配时
            if cards[matchIndex].identifier == cards[index].identifier {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
            }
            cards[index].isFaceUp = true
            indexOfOneAndOnlyFaceUpCard = nil
        } else {
            for i in cards.indices {
                cards[i].isFaceUp = false
            }
            indexOfOneAndOnlyFaceUpCard = index
            cards[index].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards.append(card)
            // 当放入集合中struct也会被复制
            cards.append(card)
            
            // 另一种方式
//            cards += [card, card]
        }
        
        cards.shuffle()
    }
    
}
