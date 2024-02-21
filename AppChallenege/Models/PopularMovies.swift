//
//  PopularMovies.swift
//  AppChallenege
//
//  Created by Khaled Abo hassob on 17/2/2024.
//

import Foundation

struct Popular: Codable {
    let page: Int?
    let results: [PopularResults]
    let total_pages: Int?
    let total_results: Int?
}

struct SearchParameter: Codable {
    var query: String? = nil
}

struct PopularResults: Codable {
    let adult: Bool?
    let backdrop_path: String?
    let genre_ids : [Int]?
    let id: Int?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let popularity: Float?
    let poster_path: String?
    let release_date: String?
    let title: String?
    let video: Bool?
    let vote_average: Float?
    let vote_count: Int?
}

struct PopularParam: Codable {
    var language: String? = nil
    var pages: Int32? = nil
    
    var asDictionary : [String: Any?] {
            let mirror = Mirror(reflecting: self)
            let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:Any?, value: Any) -> (String, Any)? in
                guard let label = label else { return nil }
                return (label, value) as? (String, Any)
            }).compactMap { $0 })
            return dict
        }
}

