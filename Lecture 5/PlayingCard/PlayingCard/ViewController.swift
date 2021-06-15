//
//  ViewController.swift
//  PlayingCard
//
//  Created by xenon on 2021/6/8.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for _ in 1...10 {
            if let card = deck.draw() {
                print(card.description)
            }
        }
    }

}
