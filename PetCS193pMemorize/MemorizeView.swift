//
//  MemorizeView.swift
//  PetCS193pMemorize
//
//  Created by Sergey Borovkov on 07.05.2021.
//

import SwiftUI

struct MemorizeView: View {
    @ObservedObject var viewModel : EmojiMemoryGame
    
    var body: some View {
        Grid(viewModel.cards){card in
            CardView(card: card)
                .padding(7)
                .onTapGesture {
                    viewModel.Choose(card: card)
                }
        }
    }
}

struct CardView: View {
    var card: Memorize<String>.Card
    
    var body: some View {
        GeometryReader(){ geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View{
        ZStack(){
            let carColor = card.isFacedUp ? Color.white : Color.orange
            if !card.isMatched {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(carColor)
            }
            if card.isFacedUp {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineWidth: frameSize)
                .foregroundColor(.orange)
                Text(card.content).font(.system(size:
                    CGFloat( size.height < size.width ? size.height : size.width ) * contentSizeMultiplyer )
                )
            }
        }
    }
    
    let cornerRadius: CGFloat = 25.0
    let contentSizeMultiplyer: CGFloat = 0.75
    let frameSize: CGFloat = 5.0
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MemorizeView( viewModel: EmojiMemoryGame())
        }
    } 
}
