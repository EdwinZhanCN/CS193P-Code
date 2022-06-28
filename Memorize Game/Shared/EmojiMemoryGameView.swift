//
//  EmojiMemoryGame.swift
//  Memory
//
//  Created by 詹子昊 on 2022/1/6.
//


import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
            .padding(5)
            }
                .padding()
                .foregroundColor(Color.blue)
    }
}

struct CardView: View{
    var card: MemoryGame<String>.Card
    
    var body: some View{
        GeometryReader(content: { geometry in
            ZStack{
                if card.isFaceUp{
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(lineWidth: edgeLineWidth)
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90),clockwise: true)
                        .padding(5).opacity(0.5)
                    Text(card.content)
                }else{
                    if !card.isMatched{
                        RoundedRectangle(cornerRadius: cornerRadius).fill()
                    }
                }
            }
            .font(Font.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor))
        })
    }
    //MARK: -Drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private let fontScaleFactor: CGFloat = 0.70
}





















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
