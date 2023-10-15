//
//  stanfordCourseApp.swift
//  stanfordCourse
//
//  Created by Yury Regis on 17/08/2023.
//

import SwiftUI

@main
struct stanfordCourseApp: App {
    let memoryGame = EmojiMemoryGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: memoryGame)
        }
    }
}
