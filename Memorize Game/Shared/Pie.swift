//
//  Pie.swift
//  Memorize Game
//
//  Created by Jiacheng Zhao on 6/27/22.
//

import SwiftUI

struct Pie:Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false

    var animatableData: AnimatablePair<Double, Double> {
        get{
            AnimatablePair(startAngle.radius, endAngle.radius)
        }

        set{
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path{
        let center =  CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(x: center.x + radius * cos(CGFloat(startAngle.radians)), y: center.y + radius * sin(CGFloat(startAngle.radians)))
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )
        return p
    }
}
