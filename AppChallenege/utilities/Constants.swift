//
//  Constants.swift
//  AppChallenege
//
//  Created by Khaled Abo hassob on 17/2/2024.
//

import Foundation

struct URLs {
    static let base = "https://api.themoviedb.org/3"
    static let popularMovie = "/movie/popular"
    static let movieGenre = "/genre/movie/list"
    static let movieSearch = "/search/movie"
    static let imageURL = "https://image.tmdb.org/t/p/w500"
}

struct HeaderKeys{
    static let Authorization = "Authorization"
}

struct HeadersValues {
    static let authKey = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMGY5OTJmZWE2NGVhYmE2MWQxYWMzNDY1YTY0MjBhZCIsInN1YiI6IjY1Y2Y0NzAyODczZjAwMDE2NzBkMWU0NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.yMdC4eY9cJldBRRsm_L2lNGeILB56Kh2muXiW_UDPw4"
}

struct Strings {
    static let popularLabelText = "Popular right now"
}

struct Fonts {
    static let jomhuriaFont = "Jomhuria-Regular"
    static let interBold = "Inter-Bold"
    static let interRegular = "Inter-Regular"
}
