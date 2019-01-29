//
//  Deck.swift
//  SetCardGame
//
//  Created by Reysmer Valle on 9/25/18.
//  Copyright © 2018 Reysmer Valle. All rights reserved.
//

import Foundation

struct Deck {
    
    private(set) var cards: [Card] = [Card]()
    
    init() {
        for symbol in Card.Symbol.all {
            for shade in Card.Shade.all {
                for number in Card.Number.all {
                    for color in Card.Color.all {
                        cards += [Card(symbol: symbol, shade: shade, number: number, color: color)]
//                        cards.append(Card(symbol: symbol, shade: shade, number: number, color: color))
                    }
                }
            }
        }
    }
    
    mutating public func draw() -> Card? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
