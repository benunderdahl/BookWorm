import Foundation
import SwiftUI

class MangaViewModel: ObservableObject {
    @Published var mangaResults: [MangaData] = []
    @Published var searchResults: [MangaData] = []
    @Published var searchText: String = ""

    private let storageKey = "mangaResultsData"

    init() {
        loadPersistedManga()
    }
    
    func addToMyBooks(_ manga: MangaData) {
        if let index = mangaResults.firstIndex(where: { $0.id == manga.id }) {
            mangaResults[index].isMyBook = true
        } else {
            var newManga = manga
            newManga.isMyBook = true
            mangaResults.append(newManga)
        }
        saveMangaResults()
    }


    func loadPersistedManga() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([MangaData].self, from: data) {
            mangaResults = decoded
        }
    }
    
    func deleteManga(_ manga: MangaData) {
        mangaResults.removeAll { $0.id == manga.id }
    }
    
    func addToFavorites(_ manga: MangaData) {
        if let index = mangaResults.firstIndex(where: { $0.id == manga.id }) {
            mangaResults[index].isFavoriteSafe.toggle()
            saveMangaResults()
        }
    }
    
    func addToRead(_ manga: MangaData) {
        if let index = mangaResults.firstIndex(where: { $0.id == manga.id }) {
            mangaResults[index].toBeReadSafe.toggle()
            saveMangaResults()
        }
    }

    func saveMangaResults() {
        if let encoded = try? JSONEncoder().encode(mangaResults) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    @MainActor
    func fetchAndSaveManga(for query: String) async {
        do {
            var model = try await fetchManga(query: query)
            
            for i in 0..<model.data.count {
                if let coverID = fetchCoverID(from: model.data[i]),
                   let fileName = try await fetchCoverFileName(from: coverID) {
                    model.data[i].fileName = fileName
                }
            }
            self.searchResults = model.data 
            saveMangaResults()
        } catch {
            print("Error fetching manga: \(error)")
        }
    }

    func fetchManga(query: String) async throws -> MangaModel {
        guard let url = URL(string: "\(mangaEndpoint)?title=\(query)&limit=50") else { return MangaModel(data: [] )}
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(MangaModel.self, from: data)
    }

    func fetchCoverID(from manga: MangaData) -> String? {
        manga.relationships.first { $0.type == "cover_art" }?.id
    }

    func fetchCoverFileName(from coverID: String) async throws -> String? {
        let urlString = "\(coverEndpoint)\(coverID)"
        guard let url = URL(string: urlString) else { return nil }

        let (data, _) = try await URLSession.shared.data(from: url)
        struct SingleCoverResponse: Decodable {
            let data: CoverStruct.MangaDataCover
        }

        let decoded = try JSONDecoder().decode(SingleCoverResponse.self, from: data)
        return decoded.data.attributes.fileName
    }
}
