import SwiftUI

struct Cardify: viewModifer, Animatable{
    var rotation: Double

    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    

    var isFaceUp: Bool{
        rotation < 90
    }

    var animatableData: Double{
        get{ return rotation}
        set{ rotation = newValue}
    }

    func body(content: Content) -> some View{
        Zstack{
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(lineWidth: edgeLineWidth)
                content
            }
                .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)
        }
    }
    .roation3DEffect(angle:degrees(card.isFaceUp ? 0 : 180), axis:(0,1,0))

    //MARK: -Drawing Constants

    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3

}

extension View {
    func cardify(isFaceUp: Bool) -> some View{
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
    
}