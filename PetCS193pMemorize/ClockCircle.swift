//
//  ClockCircle.swift
//  PetCS193pMemorize
//
//  Created by Sergey Borovkov on 18.05.2021.
//

import SwiftUI

struct ClockCircle: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var isClockWIse: Bool = true

    var animatableData: AnimatablePair<Double,Double>{
        get{ AnimatablePair(startAngle.radians, endAngle.radians) }
        set{
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }

    func path(in rect: CGRect) -> Path {
        let middle = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: middle.x + radius * cos(CGFloat(startAngle.radians)),
            y: middle.y + radius * sin(CGFloat(startAngle.radians))
            )

        var p = Path()
        p.move(to: middle)
        p.addLine(to: start)
        p.addArc(
            center: middle,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: isClockWIse
            )
        p.addLine(to: middle)
        return p
    }

}
