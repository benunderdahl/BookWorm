//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Ben Underdahl on 2/26/25.
//

import SwiftUI

@main
struct BookWormApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//
//  ContentView.swift
//  BookWorm
//
//  Created by Ben Underdahl on 2/26/25.
//

import SwiftUI
import UIKit


//struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            Form {
//                Section {
//                    HStack {
//                        Text("To Be Read")
//                        Spacer()
//                        NavigationLink(destination: ToBeRead()) {
//                            Label("", systemImage: "book")
//                        }
//                    }
//                }
//                Section {
//                    HStack {
//                        Text("Add")
//                        Spacer()
//                        Button(action: {
//                        }) {
//                            Label("", systemImage: "plus")
//                                .foregroundStyle(.red)
//                        }
//                    }
//                }
//                Section {
//                    HStack {
//                        Text("Favorites")
//                        Spacer()
//                        Button(action: {
//                            print("OOGA")
//                        }) {
//                            Label("", systemImage: "heart.fill")
//                                .foregroundStyle(.red)
//                        }
//                    }
//                }
//            }
//            .navigationTitle(Text("BookWorm"))
//            .navigationBarTitleDisplayMode(.inline)
//            NavigationLink(destination: ToBeRead()) {
//                HStack {
//                    Text("alskdf")
//                    Spacer()
//                    Image(systemName: "book")
//                }
//            }
//        }
//        
//        Image("books")
//            .resizable()
//            .scaledToFit( )
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//    }
//}
//  
//
//#Preview {
//    ContentView()
//}
