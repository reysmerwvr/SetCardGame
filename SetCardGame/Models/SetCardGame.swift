//
//  SetCardGame.swift
//  SetCardGame
//
//  Created by Reysmer Valle on 9/25/18.
//  Copyright © 2018 Reysmer Valle. All rights reserved.
//

import Foundation

struct SetCardGame {
    
    private(set) var cards: [Card] = [Card]()
    
    init(numberOfCards: Int) {
        assert(numberOfCards >= 12, "SetCardGame.init(at: \(numberOfCards)): you must at least twelve cards")
        for _ in 0..<numberOfCards {
            let card = Card()
            cards += [card]
        }
        cards = faceUpCards(originalArray: cards) as! [Card]
    }
}
