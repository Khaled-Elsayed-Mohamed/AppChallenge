//
//  TableViewCell.swift
//  AppChallenege
//
//  Created by Khaled Abo hassob on 18/2/2024.
//

import Foundation

struct GenreResponse: Codable {
    var genres: [GenreData]?
}

struct GenreData: Codable {
    var id: Int?
    var name: String?
}

