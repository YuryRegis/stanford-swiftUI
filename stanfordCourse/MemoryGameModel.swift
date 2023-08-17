//
//  MemoryGameModel.swift
//  stanfordCourse
//
//  Created by Yury Regis on 17/08/2023.
//

import Foundation

struct MemoryGameModel<CardContent> {
    var cards: Array<Card>
    
    init(numberOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        self.cards = Array<Card>()
        for pairIndex in 0..<numberOfCards {
            let cardContent = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex*2, isMatch: false, isFaceUp: true, content: cardContent))
            cards.append(Card(id: pairIndex*2+1, isMatch: false, isFaceUp: true, content: cardContent))
        }
        self.cards = self.cards.shuffled()
    }
    
    func chooseCard (_ card: Card) {
        print("Carta escolhida: \(card)")
    }
    
    struct Card: Identifiable {
        var id: Int
        var isMatch: Bool
        var isFaceUp: Bool
        var content: CardContent
    }
}
