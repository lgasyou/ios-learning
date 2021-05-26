//
//  ViewController.swift
//  Concentration
//
//  Created by xenon on 2021/5/24.
//

import UIKit

// MVC中的Controller
// View则是UIKit中的控件
class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var filpCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(filpCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!

    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        filpCount += 1;
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .none : .orange
            }
        }
    }
    
    var emojiChoices = ["👻", "🎃", "😁", "😶‍🌫️", "😡", "🤖"]
    
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        }
        
        // 这里用,表示&&
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            // 这个arc4random是啥 使用arc4random()、arc4random_uniform()取得随机数 https://www.jianshu.com/p/51269165c3e0
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        // 以上注释代码的等价写法
        return emoji[card.identifier] ?? "?"
    }
    
}
