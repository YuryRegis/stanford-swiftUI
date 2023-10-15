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
            cards.append(Card(id: pairIndex*2, content: cardContent))
            cards.append(Card(id: pairIndex*2+1, content: cardContent))
        }
        self.cards = self.cards.shuffled()
    }
    
    mutating func chooseCard (_ card: Card) {
        let indexOfCard = cards.firstIndex { cardElement in
            cardElement.id == card.id
        } ?? 0
        cards[indexOfCard].isFaceUp.toggle()
    }
    
    struct Card: Identifiable {
        var id: Int
        var content: CardContent
        var isMatch: Bool   = false
        var isFaceUp: Bool  = false
    }
}
