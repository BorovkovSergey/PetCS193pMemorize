//
//  Memorize.swift
//  PetCS193pMemorize
//
//  Created by Sergey Borovkov on 07.05.2021.
//

import Foundation

struct Memorize<ContentType> where ContentType: Equatable {
    private(set) var cards : [Card]
    
    private var chosenCardIndex: Int? {
        get{ cards.indices.filter{ cards[$0].isFacedUp }.only }
        set{
            for i in cards.indices {
                cards[i].isFacedUp = i == newValue
            }
        }
    }
    
    init(pairsOfCardsCount : Int, cardContentFactory : (Int)->ContentType) {
        cards = [Card]()
        for index in 0..<pairsOfCardsCount
        {
            let cardContent = cardContentFactory(index)
            cards.append(Card(content: cardContent, id: index*2))
            cards.append(Card(content: cardContent, id: index*2+1))
        }
    }
    
    mutating func Choose(card: Card){
        if let chosenIndex = cards.GetIndexByID(elem: card) {
            if let potentialMatchedIndex = chosenCardIndex {
                if cards[chosenIndex].content == cards[potentialMatchedIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchedIndex].isMatched = true
                }
                cards[chosenIndex].isFacedUp = true
            } else {
                chosenCardIndex = chosenIndex
            }
        }
    }
    
    struct Card: Identifiable {
        var content : ContentType
        var isFacedUp = false
        var isMatched = false
        var id: Int
    }
}
    	
