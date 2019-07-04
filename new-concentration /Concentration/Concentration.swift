//
//  Concentration.swift
//  Concentration
//
//  Created by Jack He on 6/10/19.
//  Copyright © 2019 Stanford University: Jack He. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var indexOfOnlyFaceUpCard:Int?
    
    func chooseCard(at index:Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOnlyFaceUpCard, matchIndex != index {
                //check if cards match when there is only one face up card.
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOnlyFaceUpCard = nil
            }
            else {
                //when two cards are face up or when all cards are faced-down
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOnlyFaceUpCard = index
            }
        }
    }
    init(numberOfPairsOfCards:Int){
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
    }
        //ToDo: shuffle the cards
        cards = cards.shuffled()
  }
}
