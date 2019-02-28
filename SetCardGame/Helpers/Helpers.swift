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

func countEqualities(propertyArray : [String]) -> Int {
    var repeatedElements: Dictionary<String, Int> = [:]
    if propertyArray.count > 0 {
        for value in propertyArray {
            if let element = repeatedElements[value] {
                repeatedElements[value] = element + 1
            } else {
                repeatedElements[value] = 1
            }
        }
    }
    var equalities = 1
    for (_,value) in repeatedElements {
        if value > equalities {
            equalities = value
        }
    }
    return equalities
}

func combinations<T>(array:[T], size:Int) -> [[T]] {
    if(size > array.count || size == 0 || array.count == 0) {
        return [];
    }
    if(size == array.count) {
        return [array];
    }
    var combs:[[T]] = [];
    if(size == 1) {
        for item in array {
            combs.append([item]);
        }
        return combs;
    }
    for i in 0...(array.count - size) {
        let tails = combinations(array: Array(array[(i+1)..<array.endIndex]), size: size-1)
        for tail in tails {
            let element = [array[i]] + tail;
            combs.append(element);
        }
    }
    return combs;
}
