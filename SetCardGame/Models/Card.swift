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
    
    init() {
        self.uuid = UUID().uuidString
        self.isFaceUp = false
    }
}
