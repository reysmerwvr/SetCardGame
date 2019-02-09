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

func allEqualUsingContains<T : Equatable>(array : [T]) -> Bool {
    if let firstElem = array.first {
        return !array.contains { $0 != firstElem }
    }
    return true
}

func getCardsArrayCombinations(arrayOfCards: [Card], k: Int)
    -> Array<Array<Card>> {
    var arrayOfCardsCopy = arrayOfCards
    var combinationsArray: Array<Array<Card>> = [[]]
    var auxArray: Array<Array<Card>> = [[]]
    var next: Array<Card> = []
    for (index, value) in arrayOfCardsCopy.enumerated() {
        if(k == 1) {
            combinationsArray.append([value])
        } else {
            arrayOfCardsCopy.remove(at: index  + 1)
            auxArray = getCardsArrayCombinations(arrayOfCards: arrayOfCardsCopy,
                                                 k: k-1);
            for (_, value1) in auxArray.enumerated() {
                next = value1
                next.insert(value, at: 0)
                combinationsArray.append(next);
            }
        }
    }
    return combinationsArray
}
