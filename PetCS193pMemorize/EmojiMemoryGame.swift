//
//  EmojiMemoryGame.swift
//  PetCS193pMemorize
//
//  Created by Sergey Borovkov on 07.05.2021.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    
    static func GameFactory() -> Memorize<String> {
        let emojis = ["👺","👀","🙉","💥","🍋"]
        return Memorize<String>(pairsOfCardsCount: emojis.count){ index in emojis[index] }
    }
    
    var model = EmojiMemoryGame.GameFactory()

    var cards: [Memorize<String>.Card] {
        model.cards
    }
    
    func Choose(card: Memorize<String>.Card){
        print(card) // TODO: fixme
    }
}