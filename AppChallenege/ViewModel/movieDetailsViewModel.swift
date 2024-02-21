//
//  movieDetailsViewModel.swift
//  AppChallenege
//
//  Created by Khaled Abo hassob on 18/2/2024.
//

import Foundation
import SDWebImage
protocol MovieDetailsViewModelProtocol: AnyObject {
    func setMovie() -> PopularResults
    func downloadImage(with item: PopularResults,imageURL: URL, completion: @escaping (UIImage?) -> Void)
    
}

class MovieDetailsViewModel {
    private weak var view: MovieDetailsVCProtocol?
    private var result: PopularResults?
    private var genres: [GenreData] = []

    // MARK:- Init
    init(view: MovieDetailsVCProtocol?, result: PopularResults?) {
        self.view = view
        self.result = result
    }
    
    private func getMoviesGenres(language: String) {
        APIManager.getMovieGenre(with: language) { result in
            switch result {
                
            case .success(let response):
                if let genres = response.genres {
                    self.genres = genres
                }
                print(response, "aasas")
            case .failure(let error):
                print(error, "Errorrr")
            }
        }
    }
    
    
}

extension MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    
    func setMovie() -> PopularResults  {
        return self.result!
    }
    
    func downloadImage(with item: PopularResults,imageURL: URL, completion: @escaping (UIImage?) -> Void) {
        SDWebImageManager.shared.loadImage(with: imageURL, options: .highPriority, progress: nil) { (image, _, error, _, _, _) in
            if let error = error {
                print(error.localizedDescription)
            } else if let image = image {
                print(image, "postttter")
                completion(image)
            }
        }
//        URL(string: URLs.imageURL + (item.backdrop_path ?? ""))
    }
    

    
}
