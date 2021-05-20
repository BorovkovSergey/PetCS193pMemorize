//
//  Cardify.swift
//  PetCS193pMemorize
//
//  Created by Sergey Borovkov on 18.05.2021.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double

    var isFacedUp: Bool {
        rotation < 90
    }

    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }


    init( isFacedUp: Bool )
    {
        rotation = isFacedUp ? 0 : 180
    }
    func body(content: Content) -> some View {
        ZStack(){
            Group{
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill( isFacedUp ? Color.white : Color.orange )
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: frameSize)
                content
            }
            .opacity(isFacedUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFacedUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
    let cornerRadius: CGFloat = 25.0
    let frameSize: CGFloat = 5.0
}

extension View {
    func cardify(isFacedUp: Bool) -> some View {
        self.modifier(Cardify(isFacedUp: isFacedUp))
    }
}
