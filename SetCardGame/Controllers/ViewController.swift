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
        drawInitialButtons()
    }
    
    private func drawInitialButtons() {
        for index in cardButtons.indices {
            if let cards = self.setCardGame?.playingCards {
                let card = cards[index]
                if(card.isFaceUp) {
                    let attributes = getCardShadeAttributes(card: card)
                    let textContent = getCardTextContent(card: card)
                    let attributedString = NSAttributedString(
                        string: textContent, attributes: attributes)
                    cardButtons[index].setAttributedTitle(attributedString, for: UIControl.State.normal)
                } else {
                    cardButtons[index].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    cardButtons[index].isUserInteractionEnabled = false
                }
            }
        }
    }
    
    private func getCardShadeAttributes(card: Card) ->
        [NSAttributedString.Key: Any] {
        var defaulColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        var attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: defaulColor,
        ]
        if let cardColor = card.color {
            switch cardColor {
            case .red:
                defaulColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                attributes[.foregroundColor] = defaulColor
            case .green:
                defaulColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                attributes[.foregroundColor] = defaulColor
            case .blue:
                defaulColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                attributes[.foregroundColor] = defaulColor
            }
        }
        if let cardShade = card.shade {
            switch cardShade {
            case .solid:
                attributes[.strokeWidth] = 0
            case .open:
                attributes[.strokeWidth] = 5.0
                attributes[.strokeColor] = defaulColor
            case .striped:
                attributes[.strokeWidth] = 5.0
                attributes[.strokeColor] = defaulColor
                attributes[.strikethroughStyle] = 2.0
            }
        }
        return attributes
    }
    
    private func getCardTextContent(card: Card) -> String {
        var textContent = ""
        if let cardNumber = card.number {
            switch cardNumber {
            case .one:
                if let cardSymbol = card.symbol {
                    textContent = String(repeating: cardSymbol.rawValue,
                                         count: 1)
                }
            case .two:
                if let cardSymbol = card.symbol {
                    textContent = String(repeating: cardSymbol.rawValue,
                                         count: 2)
                }
            case .three:
                if let cardSymbol = card.symbol {
                    textContent = String(repeating: cardSymbol.rawValue,
                                         count: 3)
                }
            }
        }
        return textContent
    }

    private func verifySet(cards: [Card]) -> Bool {
        if cards.count > 0 {
            var cardProperties: [String: Array<Any>] = [:]
            for index in cards.indices {
                let card = cards[index]
                if let cardColor = card.color {
                   cardProperties.append(element: cardColor,
                                         key: "color")
                }
                if let cardShade = card.shade {
                    cardProperties.append(element: cardShade,
                                          key: "shade")
                }
                if let cardNumber = card.number {
                    cardProperties.append(element: cardNumber,
                                          key: "number")
                }
                if let cardSymbol = card.symbol {
                    cardProperties.append(element: cardSymbol,
                                          key: "symbol")
                }
            }
            verifyEqualityOnProperties(cardProperties: cardProperties)
        }
        return false
    }
    
    private func verifyEqualityOnProperties(cardProperties: Dictionary<String,
        Array<Any>>) -> Dictionary<String, Bool> {
        return [
            "color" : allEqualUsingContains(array: cardProperties["color"] as! [String]),
            "shade" : allEqualUsingContains(array: cardProperties["shade"] as! [String]),
            "number" : allEqualUsingContains(array: cardProperties["number"] as! [Int]),
            "symbol" : allEqualUsingContains(array: cardProperties["number"] as! [String]),
        ]
    }
}

extension Dictionary where Value: RangeReplaceableCollection {
    public mutating func append(element: Value.Iterator.Element,
                                key: Key) -> Value? {
        var value: Value = self[key] ?? Value()
        value.append(element)
        self[key] = value
        return value
    }
}
