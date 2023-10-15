//
//  MemoryGameModel.swift
//  stanfordCourse
//
//  Created by Yury Regis on 17/08/2023.
//

import Foundation

struct MemoryGameModel<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    private var previousSelectedCard: Int?
    
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
        if let indexOfCard = cards.firstIndex(where: {$0.id == card.id}),
           !cards[indexOfCard].isFaceUp,
           !cards[indexOfCard].isMatch
        {
            if let potentialMatchIndex = previousSelectedCard {
                if cards[indexOfCard].content == cards[potentialMatchIndex].content {
                    cards[indexOfCard].isMatch.toggle()
                    cards[potentialMatchIndex].isMatch.toggle()
                }
                previousSelectedCard = nil
            } else {
                for index in cards.indices {
                    if (cards[index].isMatch) { continue }
                    else { cards[index].isFaceUp = false }
                }
                previousSelectedCard = indexOfCard
            }
            cards[indexOfCard].isFaceUp.toggle()
        } else {
            return
        }
    }
    
    struct Card: Identifiable {
        var id: Int
        var content: CardContent
        var isMatch: Bool   = false
        var isFaceUp: Bool  = false
    }
}
