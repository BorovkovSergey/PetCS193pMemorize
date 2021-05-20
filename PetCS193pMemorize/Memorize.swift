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
        if card.isFacedUp {
            return
        }
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
        var content: ContentType
        var isFacedUp = false {
            didSet{
                if isFacedUp {
                    StartUsingBonusTime()
                } else {
                    StopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                StopUsingBonusTime()
            }
        }
        var id: Int
        var bonusTimeLimit: TimeInterval = 6
        var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        // осталось бонусного времени
        var bonusTimeRemaning: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        // осталось бонусногт рвемени в процентах
        var bonusRemaning: Double {
            return (bonusTimeLimit > 0 && bonusTimeRemaning > 0) ? bonusTimeRemaning/bonusTimeLimit : 0
        }
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaning > 0
        }
        var isConsumingBonusTime: Bool {
            return isFacedUp && !isMatched && bonusTimeRemaning > 0
        }
        private mutating func StartUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        private mutating func StopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
    	
