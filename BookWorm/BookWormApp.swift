//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Ben Underdahl on 2/26/25.
//

import SwiftUI

@main
struct BookWormApp: App {
    
    @StateObject var viewModel = MangaViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}

