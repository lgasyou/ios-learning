//
//  ViewController.swift
//  Concentration
//
//  Created by xenon on 2021/5/24.
//

import UIKit

class ViewController: UIViewController {
    
    var filpCount: Int = 0 {
        // 通常用于与UI保持一致
        // 是property中类似于getter setter的一种扩展
        didSet {
            flipCountLabel.text = "Flips: \(filpCount)"
        }
    }
    
    // !在声明时使用代表该变量不一定需要初始化
    // 在变量使用则是Optional<T>转至T，可能导致error
    // 这个weak课程之后讲，这里先不学
    @IBOutlet weak var flipCountLabel: UILabel!

    // IB: Interface Builder
    // IBOutlet相当于Android中的findViewById
    // IBOutlet与IBAction的理解 https://blog.csdn.net/kicinio/article/details/109630116
    @IBOutlet var cardButtons: [UIButton]!
    
    let emojiChoices = ["👻", "🎃", "👻", "🎃"]
    
    // IBAction就是一个动作，相当于Android中的setOnXXX函数，这里的配置相当于setOnClickListener
    @IBAction func touchCard(_ sender: UIButton) {
        filpCount += 1;
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            print("cardNumber \(cardNumber)")
            let emoji = emojiChoices[cardNumber]
            flipCard(withEmoji: emoji, on: sender)
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = .orange
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = .white
        }
    }
    
    // 利用复制时同时也会复制Action
    // 该函数已弃用，仅用于展示复制时的效果
    @IBAction func flipSecondCard(_ sender: UIButton) {
        filpCount += 1;
        flipCard(withEmoji: "🎃", on: sender)
    }
    
}
