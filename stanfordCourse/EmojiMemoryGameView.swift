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
                    withAnimation() {
                        viewModel.chooseCard(card)
                    }
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
                PieShape(initialAngle: Angle(degrees: 0-90), finalAngle: Angle(degrees: 10-90))
                            .opacity(systemDesign.opacity)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatch ? 360 : 0))
                    .animation(Animation.linear(duration: 0.5).repeatCount(2, autoreverses: false))
                    .font(Font.system(size: systemDesign.fontSize))
                    .scaleEffect(scaleContent(size: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp, isMatch: card.isMatch)
        })
    }
    private func scaleContent(size: CGSize) -> CGFloat {
        min(size.width, size.height) / (systemDesign.fontSize / systemDesign.fontScale)
    }
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * systemDesign.fontScale)
    }
}

private struct systemDesign {
    static let opacity: CGFloat         = 0.5
    static let fontSize: CGFloat        = 32
    static let fontScale: CGFloat       = 0.7
    static let aspectRatio: CGFloat     = 2/3
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
