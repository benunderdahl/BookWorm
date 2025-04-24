//
//  ContentView.swift
//  BookWorm
//
//  Created by Ben Underdahl on 2/26/25.
//

import SwiftUI
import UIKit


struct ContentView: View {
    @ObservedObject var viewModel: MangaViewModel
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: MyBooksView(viewModel: viewModel)) {
                    HStack {
                        Text("My Books")
                            .font(.headline)
                            .foregroundColor(.red)
                        Spacer()
                            .foregroundColor(.red)
                        Image(systemName: "book.fill")
                            .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .padding()
                }
                NavigationLink(destination: ToBeReadView(viewModel: viewModel)) {
                    HStack {
                        Text("To Be Read")
                            .foregroundColor(.red)
                            .font(.headline)
                        Spacer()
                            .foregroundColor(.red)
                        Image(systemName: "eyes")
                            .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .padding()
                }
                NavigationLink(destination: AddView(viewModel: viewModel)) {
                    HStack {
                        Text("Add")
                            .font(.headline)
                            .foregroundColor(.red)
                        Spacer()
                            .foregroundColor(.red)
                        Image(systemName: "plus")
                            .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .padding()
                }
                NavigationLink(destination: FavoritesView(viewModel: viewModel)) {
                    HStack {
                        Text("Favorites")
                            .font(.headline)
                            .foregroundColor(.red)
                        Spacer()
                            .foregroundColor(.red)
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .padding()
                }
                Image("books")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle(Text("BookWorm"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView(viewModel: MangaViewModel())
}
