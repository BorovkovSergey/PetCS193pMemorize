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
    
    @Published var model = EmojiMemoryGame.GameFactory()

    var cards: [Memorize<String>.Card] { model.cards }

    func GetScore() -> Int { model.score }
    func Choose(card: Memorize<String>.Card){ model.Choose(card: card) }
    func NewGame() {
        model = EmojiMemoryGame.GameFactory()
    }
}
