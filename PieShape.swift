//
//  PieShape.swift
//  stanfordCourse
//
//  Created by Yury Regis on 18/10/2023.
//

import SwiftUI

struct PieShape: Shape {
    var initialAngle: Angle
    var finalAngle: Angle
    var clockwise: Bool = false
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = (min(rect.width, rect.height) - 9) / 2
        let start  = CGPoint(
            x: center.x + radius * CGFloat(cos(initialAngle.radians)),
            y: center.y + radius * CGFloat(sin(initialAngle.radians))
        )
        
        var pen = Path()
        pen.move(to: center)
        pen.addLine(to: start)
        pen.addArc(center: center, radius: radius, startAngle: initialAngle, endAngle: finalAngle, clockwise: !clockwise)
        
        return pen
    }
}
