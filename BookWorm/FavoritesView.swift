//
//  FavoritesView.swift
//  BookWorm
//
//  Created by Ben Underdahl on 4/23/25.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject var viewModel: MangaViewModel
    
    var body: some View {
    
        NavigationStack {
            List {
                ForEach(viewModel.mangaResults.filter { $0.isFavorite == true }, id: \.id) { item in
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
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text("Favorites"))
        .font(.headline)
        .onAppear {
            viewModel.loadPersistedManga()
        }
    }
}

#Preview {
    FavoritesView(viewModel: MangaViewModel())
}
