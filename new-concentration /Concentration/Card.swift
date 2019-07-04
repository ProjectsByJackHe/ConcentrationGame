//
//  Card.swift
//  Concentration
//
//  Created by Jack He on 6/10/19.
//  Copyright © 2019 Stanford University: Jack He. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier:Int
    
    static var uniqueIdentifierFactory = 0
    
    static func getUniqueIdentifier()-> Int {
        uniqueIdentifierFactory += 1
        return uniqueIdentifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
