//
//  SetCardGame.swift
//  SetCardGame
//
//  Created by Reysmer Valle on 9/25/18.
//  Copyright © 2018 Reysmer Valle. All rights reserved.
//

import Foundation

struct SetCardGame {
    
    private var deck: Deck?
    private(set) var playingCards: [Card] = [Card]()
    private(set) var selectedCards: [Card] = [Card]()
    
    init(numberOfCards: Int) {
        assert(numberOfCards >= 12, "SetCardGame.init(at: \(numberOfCards)): you must at least twelve cards")
        self.deck = Deck()
        for _ in 0..<numberOfCards {
            if let card = self.deck?.draw() {
                playingCards += [card]
            }
        }
        playingCards = faceUpCards(originalArray: playingCards) as! [Card]
    }
    
    mutating public func selectCard(at index: Int) -> Void {
        var card = playingCards[index]
        if !card.isSelected {
            card.isSelected = true
            if selectedCards.count < 3 {
                playingCards.append(card)
            }
        } else {
            card.isSelected = false
        }
    }
}
