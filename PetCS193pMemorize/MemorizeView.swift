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
        HStack{
            Text("Score: \(viewModel.GetScore())")
                .frame( maxWidth: .infinity, alignment: .leading)
            Button("New game", action: { withAnimation(.easeInOut) { viewModel.NewGame()}})
        }
        .padding(.horizontal)
        Grid(viewModel.cards){card in
            CardView(card: card)
                .padding(7)
                .onTapGesture {
                    withAnimation(.linear(duration: 0.5)) {
                        viewModel.Choose(card: card)
                    }
                }
        }
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    var card: Memorize<String>.Card
    
    var body: some View {
        GeometryReader(){ geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaningTime: Double = 0
    private func StartBonusTimeRemaning(){
        animatedBonusRemaningTime = card.bonusRemaning
        withAnimation(.linear(duration: card.bonusTimeRemaning)) {
            animatedBonusRemaningTime = 0
        }
    }
    @ViewBuilder
    func body(for size: CGSize) -> some View{
        if card.isFacedUp || !card.isMatched
        {
            ZStack(){
                if card.isConsumingBonusTime {
                    ClockCircle(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-360*animatedBonusRemaningTime-90))
                        .opacity(opacity)
                        .onAppear(){
                            self.StartBonusTimeRemaning()
                        }
                } else {
                    ClockCircle(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-360*card.bonusRemaning-90))
                        .opacity(opacity)
                }
                Text(card.content).font(.system(size:
                    CGFloat( size.height < size.width ? size.height : size.width ) * contentSizeMultiplyer )
                )
            }
            .cardify(isFacedUp: card.isFacedUp)
            .transition(AnyTransition.scale)
        }
    }
    
    let contentSizeMultiplyer: CGFloat = 0.6
    let opacity = 0.5
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MemorizeView( viewModel: EmojiMemoryGame())
        }
    } 
}
