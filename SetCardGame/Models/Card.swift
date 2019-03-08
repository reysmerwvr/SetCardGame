//
//  Card.swift
//  SetCardGame
//
//  Created by Reysmer Valle on 9/25/18.
//  Copyright © 2018 Reysmer Valle. All rights reserved.
//

import Foundation

public struct Card: Equatable {
    
    private(set) var uuid: String
    public var isFaceUp: Bool
    public var symbol: Symbol?
    public var shade: Shade?
    public var number: Number?
    public var color: Color?
    public var isSelected: Bool
    public var isSetted: Bool
    
    public enum Symbol: String {
        case triangle = "▲"
        case circle = "●"
        case square = "■"
        
        static var all = [Symbol.triangle, Symbol.circle, Symbol.square]
    }
    
    public enum Shade: String {
        case solid = "solid"
        case striped = "striped"
        case open = "open"
        
        static var all = [Shade.solid, Shade.striped, Shade.open]
    }
    
    public enum Number: Int {
        case one = 1
        case two = 2
        case three = 3
        
        static var all = [Number.one, Number.two, Number.three]
    }
    
    public enum Color: String {
        case red = "red"
        case green = "green"
        case blue = "blue"
        
        static var all = [Color.red, Color.green, Color.blue]
    }
    
    public init(symbol: Symbol, shade: Shade, number: Number, color: Color) {
        self.uuid = UUID().uuidString
        self.isFaceUp = false
        self.symbol = symbol;
        self.shade = shade;
        self.number = number;
        self.color = color;
        self.isSelected = false
        self.isSetted = false
    }
    
    public static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
