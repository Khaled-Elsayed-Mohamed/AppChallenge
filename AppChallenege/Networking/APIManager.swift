//
//  APIManager.swift
//  AppChallenege
//
//  Created by Khaled Abo hassob on 17/2/2024.
//

import Foundation
import Alamofire

class APIManager {
    class func getPopularMovies(with popularParam: PopularParam, completion: @escaping (Result<Popular, Error>) -> Void) {
        request(APIRouter.getPopularMovies(popularParam)) { (response) in
            completion(response)
        }
    }
    
    class func getMovieGenre(with language: String, completion: @escaping (Result<GenreResponse, Error>) -> Void) {
        request(APIRouter.getMovieGenre(language)) { (response) in
            completion(response)
        }
    }
    
    class func getSearchMovies(with query: String, completion: @escaping (Result<Popular, Error>) -> Void) {
        request(APIRouter.getSearchMovie(query)) { (response) in
            completion(response)
        }
    }
    
}

extension APIManager {
    // MARK:- The request function to get results in a closure
    private static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>) -> ()) {
        // Trigger the HttpRequest using AlamoFire
        AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        .responseJSON { response in
            switch response.result {
                
            case .failure(let error):
                completion(.failure(error))
            default:
                return
            }
            print(response)
        }
    }
    
    // MARK:- The request function to get results in Bool
    private static func requestBool(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Bool) -> ()) {
        // Trigger the HttpRequest using AlamoFire
        AF.request(urlConvertible).response { (response) in
            switch response.result {
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
}
