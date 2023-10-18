//
//  EmojiMemoryGameView.swift
//  stanfordCourse
//
//  Created by Yury Regis on 17/08/2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject
    var viewModel: EmojiMemoryGameViewModel
    var body: some View {
        AspectRatioVGrid(items: viewModel.cards, aspectRatio: systemDesign.aspectRatio) { card in
            CardView(card: card)
                .padding(3)
                .onTapGesture {
                    viewModel.chooseCard(card)
                }
        }
        .font(Font.largeTitle)
        .foregroundColor(Color.orange)
    }
}

// Exemplo de componentização e combinação de elementos
struct CardView: View {
    let card: MemoryGameModel<String>.Card
    var body: some View {
        // O último argumento é um "content", então podemos reescrever um ZStack desta forma:
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: systemDesign.borderRadii)
                let content = Text(card.content).font(font(in: geometry.size))
                if (card.isFaceUp) {
                    if card.isMatch {
                        content
                        shape.fill()
                            .foregroundColor(.white)
                            .opacity(systemDesign.opacity)
                        shape.strokeBorder(lineWidth: systemDesign.borderStroke)
                            .opacity(systemDesign.opacity)
                    } else {
                        shape.fill().foregroundColor(.white)
                        shape.strokeBorder(lineWidth: systemDesign.borderStroke)
                        content
                    }
                } else {
                    content
                    shape.fill()
                }
            }
        })
    }
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * systemDesign.fontScale)
    }
}

private struct systemDesign {
    static let opacity: CGFloat         = 0.5
    static let fontScale: CGFloat       = 0.7
    static let borderRadii: CGFloat     = 9.0
    static let aspectRatio: CGFloat     = 2/3
    static let borderStroke: CGFloat    = 3.0
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGameViewModel()
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
