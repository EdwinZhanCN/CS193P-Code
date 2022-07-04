//
//  Memo_GameApp.swift
//  Memo Game
//
//  Created by 詹子昊 on 2022/7/4.
//

import SwiftUI

@main
struct Memo_GameApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
