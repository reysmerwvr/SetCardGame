//
//  Helpers.swift
//  SetCardGame
//
//  Created by Reysmer Valle on 10/7/18.
//  Copyright © 2018 Reysmer Valle. All rights reserved.
//

import Foundation

func shuffleCardsArray (originalArray arrayToShuffle: Array<Card>) -> Array<Any> {
    var originalArray = arrayToShuffle
    let arrayCount = originalArray.count
    if(arrayCount <= 0) {
        return [Any]()
    }
    var shuffled = [Card]();
    for _ in 0..<arrayCount
    {
        let rand = Int(arc4random_uniform(UInt32(originalArray.count)))
        shuffled.append(originalArray[rand])
        originalArray.remove(at: rand)
    }
    return shuffled
}

func faceUpCards (originalArray arrayToFaceUp: Array<Card>) -> Array<Any> {
    var originalArray = arrayToFaceUp
    let arrayCount = originalArray.count
    if(arrayCount <= 0) {
        return [Any]()
    }
    var facedUpArray = [Card]();
    var facedUpCount = 0
    for _ in 0..<arrayCount {
        let rand = Int(arc4random_uniform(UInt32(originalArray.count)))
        if(facedUpCount < arrayCount / 2) {
            originalArray[rand].isFaceUp = true
        }
        facedUpArray.append(originalArray[rand])
        originalArray.remove(at: rand)
        facedUpCount += 1
    }
    return facedUpArray
}
