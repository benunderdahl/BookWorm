//
//  MyBooksView.swift
//  BookWorm
//
//  Created by Ben Underdahl on 4/17/25.
//

import SwiftUI

struct MyBooksView: View {
    @ObservedObject var viewModel: MangaViewModel
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(viewModel.mangaResults.filter { $0.isMyBook == true }, id: \.id) { item in
                    VStack(alignment: .leading, spacing: 8) {
                        
                        // Show cover image (centered circle)
                        if let fileName = item.fileName {
                        let urlString = "\(pictureEndpoint)\(item.id)/\(fileName)"
                        if let url = URL(string: urlString) {
                        HStack {
                            Spacer()
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 200)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 200, height: 200)
                                    .clipShape(Circle())
                            }
                            Spacer()
                        }
                    }
                }
                    Text(item.attributes.title.en ?? "No Title")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                   
                        VStack(spacing: 10) {
                            HStack {
                                Button(action: {
                                    viewModel.addToFavorites(item)
                                }) {
                                    Label("Add to Favorites", systemImage: "heart.fill")
                                        .padding(8)
                                        .font(.system(size: 12))
                                }
                                .buttonStyle(.borderless)
                                
                                Spacer()
                                
                                Button(action: {
                                    viewModel.addToRead(item)
                                }) {
                                    Label("Add to Current Reads", systemImage: "bookmark.fill")
                                        .padding(8)
                                        .font(.system(size: 12))
                                }
                                .buttonStyle(.borderless)
                            }
                        
                        Spacer()
                            HStack {
                                Button(action: {
                                    viewModel.deleteManga(item)
                                }) {
                                    Label("Delete", systemImage: "trash.fill")
                                        .padding(8)
                                        .font(.system(size: 12))
                                }
                                .buttonStyle(.borderless)
                            }
                        Spacer()

                    }
                }
                    .padding()
                    .background(
                    RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
                    .shadow(radius: 3))
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("My Books")
            .onAppear {
                viewModel.loadPersistedManga()
            }
        }
    }
}



#Preview {
    MyBooksView(viewModel: MangaViewModel())
}

