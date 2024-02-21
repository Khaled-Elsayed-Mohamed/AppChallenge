//
//  APIRouter.swift
//  AppChallenege
//
//  Created by Khaled Abo hassob on 17/2/2024.
//

import Foundation
import Alamofire
enum APIRouter: URLRequestConvertible{
    
    // The endpoint name
    case getPopularMovies(_ PopularParam: PopularParam)
    case getMovieGenre(_ language: String)
    case getSearchMovie(_ query: String)
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .getPopularMovies, .getMovieGenre, .getSearchMovie:
            return .get
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .getPopularMovies(let popularParam):
            let results = popularParam.asDictionary.filter({$0.value != nil})
            print(results, "REsults")
            return results
        case .getMovieGenre(let language):
            return ["language": language]
        case .getSearchMovie(let query):
            return ["query": query]
        default:
            return nil
        }
    }
    
    // MARK:- Path
    private var path: String {
        switch self {
        case .getPopularMovies:
            return URLs.popularMovie
        case .getMovieGenre:
            return URLs.movieGenre
        case .getSearchMovie:
            return URLs.movieSearch
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try URLs.base.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Headers
        switch self {
            
        default:
            urlRequest.setValue(HeadersValues.authKey, forHTTPHeaderField: HeaderKeys.Authorization)
        }
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
                
            default:
                return nil
            }
        }()
        urlRequest.httpBody = httpBody
        
        // Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get :
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}

extension APIRouter {
    private func encodeToJSON<T: Encodable>(_ body: T) -> Data? {
        do {
            let anyEncodable = AnyEncodable(body)
            let jsonData = try JSONEncoder().encode(anyEncodable)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            return jsonData
        } catch {
            print(error)
            return nil
        }
    }
}

// type-erasing wrapper
struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}



