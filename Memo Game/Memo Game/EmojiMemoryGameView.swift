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
        VStack{
        Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration:0.75)){
                        viewModel.choose(card: card)                       
                    }
                }
            .padding(5)
            }
                .padding()
                .foregroundColor(Color.blue)
            Button(role: .destructive, action: {
                withAnimation(.easeInOut){
                    self.viewModel.resetGame()
                }
            }, label: {Text("New Game")})
        }
    }
}

struct CardView: View{
    var card: MemoryGame<String>.Card

    @State private var animateBonusRemaning: Double = 0

    private func startBonusTimeAnimation(){
        animateBonusRemaning = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)){
            animateBonusRemaning = 0
        }
    }
    
    @ViewBuilder
    var body: some View{
        GeometryReader(content: { geometry in
            if card.isFaceUp || !card.isMatched{
                ZStack{
                    Group{
                        if card.isConsumingBonusTime{
                            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animateBonusRemaning*360-90),clockwise: true)
                                .onAppear{
                                    self.startBonusTimeAnimation()
                                }
                        }else{
                            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animateBonusRemaning*360-90),clockwise: true)
                        }
                    }
                    
                    Text(card.content)
                        .font(Font.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor))
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)
                .padding(5)
            }           
        })
    }
    private let fontScaleFactor: CGFloat = 0.70
}





















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
