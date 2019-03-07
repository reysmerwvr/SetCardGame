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
    
    private(set) var setCount: Int = 0 {
        didSet {
            setCountLabel.text = "Sets: \(setCount)"
        }
    }
    
    private(set) var scoreCount: Int = 0 {
        didSet {
            scoreCountLabel.text = "Score: \(scoreCount)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCardGame = SetCardGame(numberOfCards: numberOfCards)
        drawCardsInButtons()
    }
    
    @IBAction private func onTouchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            if var setGame = setCardGame {
                setGame.selectCard(at: cardNumber)
                setCardGame = setGame
                let selectedCards = setGame.selectedCards
                if(selectedCards.count == 3) {
                    if(verifySet(cards: selectedCards)) {
                        setGame.markCardAsSet()
                        setCardGame = setGame
                        setCount += 1
                        scoreCount += 3
                    } else {
                        setGame.unSelectCards()
                        setCardGame = setGame
                        if(scoreCount >= 2) {
                            scoreCount -= 2
                        } else {
                            scoreCount = 0
                        }
                    }
                    drawCardsInButtons()
                } else {
                    selectCardAnimation(at: cardNumber)
                }
            }
        }
    }
    
    @IBAction func openCards(_ sender: UIButton) {
        if var setGame = setCardGame, let deck = setGame.deck  {
            if deck.cards.count >= 3 {
                var cards = setGame.playingCards
                let inactiveCards = cards.filter { !$0.isFaceUp }
                if inactiveCards.count >= 3 {
                    for index in 0..<3 {
                        let card = inactiveCards[index]
                        if let cardIndex = cards.firstIndex(where: { $0 == card }) {
                            cards[cardIndex].isFaceUp = true
                        }
                    }
                    setGame._playingCards = cards
                    setCardGame = setGame
                    drawCardsInButtons()
                }
            } else {
                sender.isUserInteractionEnabled = false
            }
        }
    }
    
    @IBAction func findSet(_ sender: UIButton) {
        if let setGame = setCardGame {
            let cards = setGame.playingCards
            let activeCards = cards.filter { $0.isFaceUp }
            let cardsCombinationsArray = combinations(array: activeCards, size: 3)
            var auxArrayOfCards: [Card] = []
            for arrayOfCards in cardsCombinationsArray {
                if verifySet(cards: arrayOfCards) {
                    auxArrayOfCards = arrayOfCards
                    break
                }
            }
            if auxArrayOfCards.count > 0 {
                for index in cardButtons.indices {
                    let card = cards[index]
                    let arrayhasCard = auxArrayOfCards.contains { $0 == card }
                    if arrayhasCard {
                        setCardAnimation(button: cardButtons[index], borderWidth: 3.0,
                                         cornerRadius: 3.0, borderColor: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1))
                    }
                }
            }
        }
    }
    
    @IBAction func setNewGame(_ sender: UIButton) {
        setCardGame = SetCardGame(numberOfCards: numberOfCards)
        setCount = 0
        drawCardsInButtons()
    }
    
    private func drawCardsInButtons() {
        for index in cardButtons.indices {
            if let setGame = setCardGame {
                let cards = setGame.playingCards
                let card = cards[index]
                let button = cardButtons[index]
                if(card.isFaceUp) {
                    button.backgroundColor = #colorLiteral(red: 0.8017306924, green: 0.8017306924, blue: 0.8017306924, alpha: 1)
                    let attributes = getCardShadeAttributes(card: card)
                    let textContent = getCardTextContent(card: card)
                    let attributedString = NSAttributedString(
                        string: textContent, attributes: attributes)
                    button.setAttributedTitle(attributedString, for: UIControl.State.normal)
                    button.isUserInteractionEnabled = true
                } else {
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    button.setAttributedTitle(nil, for: UIControl.State.normal)
                    button.isUserInteractionEnabled = false
                }
                setCardAnimation(button: button, borderWidth: 0.0,
                                 cornerRadius: 0.0, borderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
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
                   cardProperties["color"] = cardProperties.append(element: String(cardColor.rawValue),
                                         key: "color")
                }
                if let cardShade = card.shade {
                    cardProperties["shade"] = cardProperties.append(element: String(cardShade.rawValue),
                                          key: "shade")
                }
                if let cardNumber = card.number {
                    cardProperties["number"] = cardProperties.append(element: String(cardNumber.rawValue),
                                          key: "number")
                }
                if let cardSymbol = card.symbol {
                    cardProperties["symbol"] = cardProperties.append(element: String(cardSymbol.rawValue),
                                          key: "symbol")
                }
            }
            let setResult: Dictionary<String, Int> = verifyEqualityOnProperties(cardProperties: cardProperties)
            var countEqualities: Dictionary<Int, Int> = [:]
            for (_,value) in setResult {
                if let element = countEqualities[value] {
                    countEqualities[value] = element + 1
                } else {
                    countEqualities[value] = 1
                }
            }
            if let one = countEqualities[1], one >= 4 {
                return true
            } else if let three = countEqualities[3], let one = countEqualities[1],
                three == 3, one == 1  {
                return true
            } else if let three = countEqualities[3], let one = countEqualities[1],
                three == 2, one == 2  {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    private func verifyEqualityOnProperties(cardProperties: Dictionary<String,
        Array<Any>>) -> Dictionary<String, Int> {
        var arrayOfEqualityOfProperties: Dictionary<String, Int> = [:]
        if let colorArray = cardProperties["color"] {
            arrayOfEqualityOfProperties["color"] = countEqualities(propertyArray: colorArray as! [String])
        }
        if let shadeArray = cardProperties["shade"] {
            arrayOfEqualityOfProperties["shade"] = countEqualities(propertyArray: shadeArray as! [String])
        }
        if let numberArray = cardProperties["number"] {
            arrayOfEqualityOfProperties["number"] = countEqualities(propertyArray: numberArray as! [String])
        }
        if let symbolArray = cardProperties["symbol"] {
            arrayOfEqualityOfProperties["symbol"] = countEqualities(propertyArray: symbolArray as! [String])
        }
        return arrayOfEqualityOfProperties
    }
    
    private func selectCardAnimation(at index: Int) {
        if let setGame = setCardGame {
            let cards = setGame.playingCards
            let card = cards[index]
            let button = cardButtons[index]
            if(card.isSelected) {
                setCardAnimation(button: button, borderWidth: 3.0,
                                 cornerRadius: 3.0, borderColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            } else {
                setCardAnimation(button: button, borderWidth: 0.0,
                                 cornerRadius: 0.0, borderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
            }
        }
    }
    
    private func setCardAnimation(button: UIButton, borderWidth: CGFloat,
                                  cornerRadius: CGFloat, borderColor: CGColor) {
        button.layer.borderWidth = borderWidth
        button.layer.cornerRadius = cornerRadius
        button.layer.borderColor = borderColor
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
