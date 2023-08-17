//
//  ContentView.swift
//  stanfordCourse
//
//  Created by Yury Regis on 17/08/2023.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGameViewModel
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65, maximum: 100))], content: {
                ForEach(viewModel.cards, content: { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.chooseCard(card)
                        }
                })
            })
        }
        .padding()
        .font(Font.largeTitle)
        .foregroundColor(Color.orange)
    }
}

// Exemplo de componentização e combinação de elementos
struct CardView: View {
    var card: MemoryGameModel<String>.Card
    var body: some View {
        if card.isFaceUp {
            // O último argumento é um "content", então podemos reescrever um ZStack desta forma:
            ZStack {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).strokeBorder(lineWidth: 3)
                Text(card.content)
            }
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGameViewModel())
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        ContentView(viewModel: EmojiMemoryGameViewModel())
            .preferredColorScheme(.light)
    }
}
