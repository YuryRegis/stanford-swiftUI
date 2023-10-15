//
//  ContentView.swift
//  stanfordCourse
//
//  Created by Yury Regis on 17/08/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject
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
        .padding(.horizontal)
        .font(Font.largeTitle)
        .foregroundColor(Color.orange)
    }
}

// Exemplo de componentização e combinação de elementos
struct CardView: View {
    let card: MemoryGameModel<String>.Card
    var body: some View {
        // O último argumento é um "content", então podemos reescrever um ZStack desta forma:
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10.0)
            let content = Text(card.content).font(.largeTitle)
            if (card.isFaceUp) {
                if card.isMatch {
                    content
                    shape.fill()
                        .foregroundColor(.white)
                        .opacity(0.5)
                    shape.strokeBorder(lineWidth: 3)
                        .opacity(0.5)
                } else {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 3)
                    content
                }
            } else {
                content
                shape.fill()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGameViewModel()
        ContentView(viewModel: game)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
