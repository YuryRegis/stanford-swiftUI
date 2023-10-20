//
//  CardifyViewModifier.swift
//  stanfordCourse
//
//  Created by Yury Regis on 19/10/2023.
//

import SwiftUI

struct CardifyViewModifier: ViewModifier {
    var isFaceUp: Bool
    var isMatch: Bool
    
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: systemDesign.borderRadii)
            
            if (isFaceUp) {
                if isMatch {
                    shape.fill()
                        .foregroundColor(.white)
                        .opacity(systemDesign.opacity)
                    shape.strokeBorder(lineWidth: systemDesign.borderStroke)
                        .opacity(systemDesign.opacity)
                } else {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: systemDesign.borderStroke)
                    PieShape(initialAngle: Angle(degrees: 0-90), finalAngle: Angle(degrees: 10-90))
                        .opacity(systemDesign.opacity)
                }
            } else {
                shape.fill()
            }
            content.opacity(isFaceUp && isMatch ? systemDesign.opacity : isFaceUp ? 1 : 0)
        }
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
