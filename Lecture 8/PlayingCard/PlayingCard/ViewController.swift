//
//  ViewController.swift
//  PlayingCard
//
//  Created by xenon on 2021/6/8.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    
    @IBOutlet var playingCardViews: [PlayingCardView]!
    
    private var cards = [PlayingCard]()
    
    private lazy var animator = UIDynamicAnimator(referenceView: view)
    
    private lazy var behavior = CardBehavior(in: animator)

    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0..<playingCardViews.count / 2 + 1 {
            if let card = deck.draw() {
                cards += [card, card]
            } else {
                print("Card is not enough to draw")
            }
        }
        for cardView in playingCardViews {
            let card = cards.remove(at: cards.count.arc4random)
            cardView.isFaceUp = false
            cardView.rank = card.rank.order
            cardView.suit = card.suit.description
            
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
            behavior.addItem(cardView)
        }
    }
    
    // 以下两个函数应该放到model中，放在这里仅用于演示
    private var faceUpCardViewsMatched: Bool {
        return faceUpCards.count == 2 &&
            faceUpCards[0].rank == faceUpCards[1].rank &&
            faceUpCards[0].suit == faceUpCards[1].suit
    }
    
    private var faceUpCards: [PlayingCardView] {
        return playingCardViews.filter {
            $0.isFaceUp && !$0.isHidden
            && $0.transform != CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0)
            && $0.alpha == 1
        }
    }
    
    private var lastChosenCard: PlayingCardView?
    
    // 显然，可以看出这里有点“callback hell”的意思，用调用链更合适
    @objc func flipCard(_ gestureRecognizer: UITapGestureRecognizer) {
        switch gestureRecognizer.state {
        case .ended:
            if let cardView = gestureRecognizer.view as? PlayingCardView, faceUpCards.count < 2 {
                lastChosenCard = cardView
                behavior.removeItem(cardView)
                UIView.transition(
                    with: cardView,
                    duration: 0.6,
                    options: [.transitionFlipFromLeft],
                    animations: {
                        cardView.isFaceUp = !cardView.isFaceUp
                    },
                    completion: { finished in
                        let cardsToAnimate = self.faceUpCards
                        if self.faceUpCardViewsMatched {
                            UIViewPropertyAnimator.runningPropertyAnimator(
                                withDuration: 0.6,
                                delay: 0,
                                options: [],
                                animations: {
                                    cardsToAnimate.forEach {
                                        $0.transform = CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0)
                                    }
                                },
                                completion: { _ in
                                    UIViewPropertyAnimator.runningPropertyAnimator(
                                        withDuration: 0.75,
                                        delay: 0,
                                        options: [],
                                        animations: {
                                            cardsToAnimate.forEach {
                                                $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                                $0.alpha = 0
                                            }
                                        },
                                        completion: { _ in
                                            cardsToAnimate.forEach {
                                                $0.isHidden = true
                                                $0.alpha = 1
                                                $0.transform = .identity
                                            }
                                        }
                                    )
                                }
                            )
                        } else if cardsToAnimate.count == 2 {
                            if self.lastChosenCard == cardView {
                                cardsToAnimate.forEach { cardView in
                                    UIView.transition(
                                        with: cardView,
                                        duration: 0.6,
                                        options: [.transitionFlipFromLeft],
                                        animations: {
                                            cardView.isFaceUp = false
                                        },
                                        completion: { _ in
                                            self.behavior.addItem(cardView)
                                        }
                                    )
                                }
                            }
                        } else {
                            if !cardView.isFaceUp {
                                self.behavior.addItem(cardView)
                            }
                        }
                    }
                )
            }
        default:
            break
        }
    }
    
}
