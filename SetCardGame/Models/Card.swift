//
//  Card.swift
//  SetCardGame
//
//  Created by Reysmer Valle on 9/25/18.
//  Copyright © 2018 Reysmer Valle. All rights reserved.
//

import Foundation

struct Card {
    
    private var uuid: String
    public var isFaceUp: Bool
    public var symbol: Symbol?
    public var shade: Shade?
    public var number: Number?
    public var color: Color?
    
    enum Symbol: String {
        case triangle = "▲"
        case circle = "●"
        case square = "■"
        
        static var all = [Symbol.triangle, Symbol.circle, Symbol.square]
    }
    
    enum Shade: String {
        case solid = "solid"
        case striped = "striped"
        case open = "open"
        
        static var all = [Shade.solid, Shade.striped, Shade.open]
    }
    
    enum Number: Int {
        case one = 1
        case two = 2
        case three = 3
        
        static var all = [Number.one, Number.two, Number.three]
    }
    
    enum Color: String {
        case red = "#colorLiteral(red: 0.2638142705, green: 0.01383866463, blue: 0, alpha: 1)"
        case green = "#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)"
        case blue = "#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)"
        
        static var all = [Color.red, Color.green, Color.blue]
    }
    
    init(symbol: Symbol, shade: Shade, number: Number, color: Color) {
        self.uuid = UUID().uuidString
        self.isFaceUp = false
        self.symbol = symbol;
        self.shade = shade;
        self.number = number;
        self.color = color;
    }
}
