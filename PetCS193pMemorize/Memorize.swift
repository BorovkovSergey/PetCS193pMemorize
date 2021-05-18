//
//  Memorize.swift
//  PetCS193pMemorize
//
//  Created by Sergey Borovkov on 07.05.2021.
//

import Foundation

struct Memorize<ContentType> where ContentType: Equatable {
    var cards : [Card]
    
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
            cards[chosenIndex].isFacedUp = !cards[chosenIndex].isFacedUp
        }
    }
    
    struct Card: Identifiable {
        var content : ContentType
        var isFacedUp = false
        var isMatched = false
        var id: Int
    }
}
    	
