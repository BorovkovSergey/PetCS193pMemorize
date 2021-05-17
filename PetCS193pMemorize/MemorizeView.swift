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
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.white)
            RoundedRectangle(cornerRadius: 25.0)
                .stroke(lineWidth: 5)
                .foregroundColor(.orange)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MemorizeView( viewModel: EmojiMemoryGame())
        }
    } 
}
