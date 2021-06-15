//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by xenon on 2021/6/8.
//

import Foundation

struct PlayingCard {
    
    var suit: Suit
    
    var rank: Rank
    
    var description: String {
        return "\(suit.description)\(rank.description)"
    }
 
    // 说明enum的值类型
    enum Suit: String {
        case spades = "♠"
        case hearts = "♥"
        case diamonds = "♦"
        case clubs = "♣"
        
        static var all: [Suit] = [.spades, .hearts, .diamonds, .clubs]
        
        var description: String {
            return self.rawValue
        }
        
    }
    
    enum Rank {
        case ace
        case face(String)
        case numeric(Int)
        
        var order: Int {
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default: return 0
            }
        }
        
        static var all: [Rank] {
            var allRanks = [Rank.ace]
            for pips in 2...10 {
                allRanks.append(Rank.numeric(pips))
            }
            allRanks += [.face("J"), .face("Q"), .face("K")]
            return allRanks
        }
        
        var description: String {
            switch self {
            case .ace: return "A"
            case .numeric(let pips): return String(pips)
            case .face(let kind): return kind
            default: return "?"
            }
        }
        
    }
    
}
