//
//  ViewController.swift
//  SetCardGame
//
//  Created by Reysmer Valle on 9/22/18.
//  Copyright © 2018 Reysmer Valle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var setCountLabel: UILabel!
    
    @IBOutlet private weak var scoreCountLabel: UILabel!
    
    private var setCardGame: SetCardGame?
    
    private var numberOfCards: Int {
        return cardButtons.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCardGame = SetCardGame(numberOfCards: numberOfCards)
    }
    
    private func enableButtons() {
        for index in cardButtons.indices {
            if let cards = self.setCardGame?.cards {
                let card = cards[index]
                if(card.isFaceUp) {
                    // TODO Add Card Content
                } else {
                    cardButtons[index].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    cardButtons[index].isUserInteractionEnabled = false
                }
                
            }
        }
    }


}

