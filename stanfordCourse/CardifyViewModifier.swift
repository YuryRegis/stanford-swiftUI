//
//  CardifyViewModifier.swift
//  stanfordCourse
//
//  Created by Yury Regis on 19/10/2023.
//

import SwiftUI

struct CardifyViewModifier: AnimatableModifier {
    var rotation: Double
    var isMatch: Bool
    
    init (isFaceUp: Bool, isMatch: Bool) {
        self.rotation = isFaceUp ? 0 : 180
        self.isMatch = isMatch
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: systemDesign.borderRadii)
            let isFlipUp = rotation < 90
            
            if (isFlipUp) {
                shape.fill().foregroundColor(.white)
                shape
                    .strokeBorder(lineWidth: systemDesign.borderStroke)
                    .opacity(isMatch ? systemDesign.opacity : 1)
                PieShape(initialAngle: Angle(degrees: 0-90), finalAngle: Angle(degrees: 10-90))
                    .opacity( isMatch ? systemDesign.opacity : 1)
            } else {
                shape.fill()
            }
            content.opacity(isFlipUp && isMatch ? systemDesign.opacity : isFlipUp ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
    private struct systemDesign {
        static let opacity: CGFloat         = 0.5
        static let borderRadii: CGFloat     = 9.0
        static let borderStroke: CGFloat    = 3.0
    }
}

extension View {
    func cardify(isFaceUp: Bool, isMatch: Bool) -> some View {
        self.modifier(CardifyViewModifier(isFaceUp: isFaceUp, isMatch: isMatch))
    }
}
