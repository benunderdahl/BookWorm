//
//  MangaDexModel.swift
//  BookWorm
//
//  Created by Ben Underdahl on 4/23/25.
//

import Foundation

// Basic manga search endpoint
var mangaEndpoint = "https://api.mangadex.org/manga/"
var coverEndpoint = "https://api.mangadex.org/cover/"
var pictureEndpoint = "https://uploads.mangadex.org/covers/"


struct MangaModel: Codable {
    var data: [MangaData]
}

struct MangaData: Codable, Identifiable {
    let id: String
    let type: String?
    let attributes: MangaAttributes
    let relationships: [MangaRelationships]
    var fileName: String? = nil
    var isFavorite: Bool? = false
    var toBeRead: Bool? = false
    var isMyBook: Bool? = false
        
    var isFavoriteSafe: Bool {
        get { isFavorite ?? false }
        set { isFavorite = newValue }
      }

    var toBeReadSafe: Bool {
        get { toBeRead ?? false }
        set { toBeRead = newValue }
  }
}

struct MangaAttributes: Codable{
    let title: MangaTitle
    let description: MangaDescription
}

struct MangaTitle: Codable {
    let en: String?
}
struct MangaDescription: Codable {
    let en: String?
}

struct MangaRelationships: Codable {
    let id: String?
    let type: String?
}

struct CoverStruct: Codable {
    var data: [MangaDataCover]
    struct MangaDataCover: Codable {
        let id: String?
        let type: String?
        let attributes: CoverAttributes
    }
    struct CoverAttributes: Codable {
        var fileName: String?
    }
}
