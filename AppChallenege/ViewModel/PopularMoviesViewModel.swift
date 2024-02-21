//
//  PopularMoviesViewModel.swift
//  AppChallenege
//
//  Created by Khaled Abo hassob on 17/2/2024.
//

import Foundation
import Alamofire
import SDWebImage

protocol PopularMoviesViewModelProtocol: AnyObject {
    func getData(for index: Int) -> PopularResults
    func getDataCount() -> Int
    func getData()
    func getFilteredData(query: String) -> [PopularResults]
    func getGenresData() -> [GenreData]
    func getSearchData(text: String)
    func downloadImage(with item: PopularResults,imageURL: URL, completion: @escaping (UIImage?) -> Void)
    func setMovie() -> [PopularResults]
}

class PopularMoviesViewModel {
    
    // MARK:- Properties
    private weak var view: PopularMoviesVCProtocol?
    private var results: [PopularResults] = []
    private var genres: [GenreData] = []
    private var filteredResults: [PopularResults] = []
    
    // MARK:- Init
    init(view: PopularMoviesVCProtocol?) {
        self.view = view
    }
    
    private func getPopularMovies() {
        APIManager.getPopularMovies(with: PopularParam(language: nil, pages: nil)) { results in
            switch results {
            case .success(let response):
                self.results = response.results
                self.getMoviesGenres(language: "en")
                self.view?.reloadData()
                print(results)
            case .failure(let error):
                print(error, "Error")
            }
        }
    }
    
    private func getSearchMovies(search: String) {
        APIManager.getSearchMovies(with: search) { result in
            switch result {
            case .success(let response):
                self.filteredResults = response.results
                self.view?.reloadData()
            case .failure(let error):
                print(error, "errror")
            }
        }
    }
    
    private func getMoviesGenres(language: String) {
        APIManager.getMovieGenre(with: language) { result in
            switch result {
                
            case .success(let response):
                if let genres = response.genres {
                    self.genres = genres
                    self.view?.reloadData()
                }
                print(response, "aasas")
            case .failure(let error):
                print(error, "Errorrr")
            }
        }
    }
}

extension PopularMoviesViewModel: PopularMoviesViewModelProtocol {
    func setMovie() -> [PopularResults] {
        return self.results
    }
    
    func getSearchData(text: String) {
        getSearchMovies(search: text)
    }
    
    func getFilteredData(query: String) -> [PopularResults] {
        return self.filteredResults
    }
    
  
    func getGenresData() -> [GenreData] {
        return self.genres
    }
    
    func getDataCount() -> Int {
        return self.results.count
    }
    
    func getData(for index: Int) -> PopularResults {
        return self.results[index]
    }
    
    func getData() {
        getPopularMovies()
    }
    
    func downloadImage(with item: PopularResults,imageURL: URL, completion: @escaping (UIImage?) -> Void) {
        SDWebImageManager.shared.loadImage(with: imageURL, options: .highPriority, progress: nil) { (image, _, error, _, _, _) in
            if let error = error {
                print(error.localizedDescription)
            } else if let image = image {
                print(image, "posterrrr")
                completion(image)
            }
        }
    }
    
    
}
