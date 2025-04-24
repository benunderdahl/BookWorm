//
//  AddView.swift
//  BookWorm
//
//  Created by Ben Underdahl on 4/23/25.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var viewModel: MangaViewModel
    @StateObject var searchModel = MangaViewModel()
    @FocusState private var searchField: Bool
    @State private var showAlert = false


    var body: some View {
        NavigationStack {
            VStack {
                // Search field
                TextField("Search Manga by Title", text: $searchModel.searchText)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .focused($searchField)
                    .onSubmit {
                        Task {
                            await searchModel.fetchAndSaveManga(for: searchModel.searchText)
                        }
                    }

                // Manga results list
                List(searchModel.searchResults, id: \.id) { item in
                    LazyVStack(alignment: .leading, spacing: 8) {
                        // Cover image (centered circle)
                        if let fileName = item.fileName {
                            let urlString = "\(pictureEndpoint)\(item.id)/\(fileName)"
                            if let url = URL(string: urlString) {
                                HStack {
                                    Spacer()
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                    }
                                    Spacer()
                                }
                            }
                        }

                        // Title
                        Text(item.attributes.title.en ?? "No Title")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)

                        // Description
                        Text(item.attributes.description.en ?? "No Description")
                            .font(.subheadline)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)

                        // Save button
                        HStack {
                            Spacer()
                            Button(action: {
                                viewModel.addToMyBooks(item)
                                showAlert = true
                            }) {
                                Label("Add to Books", systemImage: "book.circle.fill")
                            }
                            .foregroundColor(.cyan)
                            .buttonStyle(.borderedProminent)
                            Spacer()
                        }
                       
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemGray6))
                            .shadow(radius: 3)
                    )
                    .padding(.vertical, 4)
                }
            }
            .onAppear {
                searchField = true
                searchModel.loadPersistedManga()
            }
            .navigationTitle("Add Books To Your Library")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Added To My Books", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("New Book Added to your Library")
            }
        }
    }
}

#Preview {
    AddView(viewModel: MangaViewModel())
}
