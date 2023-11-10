//
//  movieDetails.swift
//  21
//
//  Created by Lika Nozadze on 11/10/23.
//


import UIKit

struct resultsList: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String
    let posterPath: String
    let overview: String
    let voteAverage: Double
}

let apiKey = "b3f94306203eb8a05798bd8b0e8911b2"

func fetchMoviesFromAPI() async throws -> [Movie] {
    let urlString = "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc&without_genres=99,10755&vote_count.gte=200&api_key=\(apiKey)"
    

    let url = URL(string: urlString)!
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    
    do {
        let decoded = try decoder.decode(resultsList.self, from: data)
        return decoded.results
    } catch {
        throw error
    }
    
}
