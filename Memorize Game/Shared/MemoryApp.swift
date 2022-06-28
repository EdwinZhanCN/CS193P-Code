//
//  MemoryApp.swift
//  Memory
//
//  Created by 詹子昊 on 2022/1/6.
//

import SwiftUI

@main
struct MemoryApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
