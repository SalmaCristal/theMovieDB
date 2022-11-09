//
//  EntityDetalleMovie.swift
//  theMovieDB
//
//  Created by Salma Garcia on 05/11/22.
//

import Foundation

// MARK: - Welcome
struct DetalleMovie: Codable {
        let adult: Bool
        let backdropPath: String?
        let createdBy: [CreatedBy]?
        let episodeRunTime: [Int]?
        let firstAirDate: String?
        let genres: [Genre]
        let homepage: String
        let id: Int
        let inProduction: Bool?
        let languages: [String]?
        let lastAirDate: String?
        let lastEpisodeToAir: TEpisodeToAir?
        let name: String?
        let nextEpisodeToAir: TEpisodeToAir?
        let networks: [ProductionCompany]?
        let numberOfEpisodes, numberOfSeasons: Int?
        let originCountry: [String]?
        let originalLanguage: String
        let originalName: String?
        let overview: String
        let popularity: Double
        let posterPath: String
        let productionCompanies: [ProductionCompany]
        let productionCountries: [ProductionCountry]
        let seasons: [Season]?
        let spokenLanguages: [SpokenLanguage]
        let status, tagline: String
        let type: String?
        let voteAverage: Double
        let voteCount: Int
        let belongsToCollection: BelongsToCollection?
        let budget: Int?
        let imdbID, originalTitle, releaseDate: String?
        let revenue, runtime: Int?
        let title: String?
        let video: Bool?

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case createdBy = "created_by"
            case episodeRunTime = "episode_run_time"
            case firstAirDate = "first_air_date"
            case genres, homepage, id
            case inProduction = "in_production"
            case languages
            case lastAirDate = "last_air_date"
            case lastEpisodeToAir = "last_episode_to_air"
            case name
            case nextEpisodeToAir = "next_episode_to_air"
            case networks
            case numberOfEpisodes = "number_of_episodes"
            case numberOfSeasons = "number_of_seasons"
            case originCountry = "origin_country"
            case originalLanguage = "original_language"
            case originalName = "original_name"
            case overview, popularity
            case posterPath = "poster_path"
            case productionCompanies = "production_companies"
            case productionCountries = "production_countries"
            case seasons
            case spokenLanguages = "spoken_languages"
            case status, tagline, type
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
            case belongsToCollection = "belongs_to_collection"
            case budget
            case imdbID = "imdb_id"
            case originalTitle = "original_title"
            case releaseDate = "release_date"
            case revenue, runtime, title, video
        }
    }

    // MARK: - BelongsToCollection
    struct BelongsToCollection: Codable {
        let id: Int
        let name, posterPath, backdropPath: String

        enum CodingKeys: String, CodingKey {
            case id, name
            case posterPath = "poster_path"
            case backdropPath = "backdrop_path"
        }
    }

    // MARK: - CreatedBy
    struct CreatedBy: Codable {
        let id: Int
        let creditID, name: String
        let gender: Int
        let profilePath: String?

        enum CodingKeys: String, CodingKey {
            case id
            case creditID = "credit_id"
            case name, gender
            case profilePath = "profile_path"
        }
    }

    // MARK: - Genre
    struct Genre: Codable {
        let id: Int
        let name: String
    }

    // MARK: - TEpisodeToAir
    struct TEpisodeToAir: Codable {
        let airDate: String
        let episodeNumber, id: Int
        let name, overview: String
        let productionCode: ProductionCode
        let runtime: Int?
        let seasonNumber, showID: Int
        let stillPath: String?
        let voteAverage: Double
        let voteCount: Int

        enum CodingKeys: String, CodingKey {
            case airDate = "air_date"
            case episodeNumber = "episode_number"
            case id, name, overview
            case productionCode = "production_code"
            case runtime
            case seasonNumber = "season_number"
            case showID = "show_id"
            case stillPath = "still_path"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }

    enum ProductionCode: String, Codable {
        case empty = ""
        case the9965K = "9965K"
    }

    // MARK: - Network
    struct ProductionCompany: Codable {
        let id: Int
        let name: String
        let logoPath: String?
        let originCountry: String

        enum CodingKeys: String, CodingKey {
            case id, name
            case logoPath = "logo_path"
            case originCountry = "origin_country"
        }
    }

    // MARK: - ProductionCountry
    struct ProductionCountry: Codable {
        let iso3166_1, name: String

        enum CodingKeys: String, CodingKey {
            case iso3166_1 = "iso_3166_1"
            case name
        }
    }

    // MARK: - Season
    struct Season: Codable {
        let airDate: String?
        let episodeCount, id: Int
        let name, overview: String
        let posterPath: String?
        let seasonNumber: Int

        enum CodingKeys: String, CodingKey {
            case airDate = "air_date"
            case episodeCount = "episode_count"
            case id, name, overview
            case posterPath = "poster_path"
            case seasonNumber = "season_number"
        }
    }

    // MARK: - SpokenLanguage
    struct SpokenLanguage: Codable {
        let englishName, iso639_1, name: String

        enum CodingKeys: String, CodingKey {
            case englishName = "english_name"
            case iso639_1 = "iso_639_1"
            case name
        }
    }

    typealias detalleMovie = [DetalleMovie]



// MARK: - Welcome
struct DetalleVideo: Codable {
    let id: Int
    let results: [Video]
}

// MARK: - Result
struct Video: Codable {
    let iso639_1, iso3166_1, name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

