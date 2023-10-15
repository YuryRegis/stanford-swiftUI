//
//  EmojiMemoryGameViewModel.swift
//  stanfordCourse
//
//  Created by Yury Regis on 17/08/2023.
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    @Published
    private var model: MemoryGameModel<String> = EmojiMemoryGameViewModel.createGame()
    
    static func createGame() -> MemoryGameModel<String> {
        let emojis = ["👻", "🕷️", "🎃", "👽", "🫀", "👹", "🧠", "🕸️", "🔪", "⚰️", "⛓️", "🪓", "💀", "🐀", "🫁"]
        return MemoryGameModel<String>(numberOfCards: emojis.count) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    // MARK: Access to the model
    var cards: Array<MemoryGameModel<String>.Card> {
        model.cards
    }
    
    // MARK: - Intents
    func chooseCard(_ card: MemoryGameModel<String>.Card) {
        model.chooseCard(card)
    }
}
