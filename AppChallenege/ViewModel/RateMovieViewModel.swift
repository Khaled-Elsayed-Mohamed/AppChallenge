//
//  RateMovieViewModel.swift
//  AppChallenege
//
//  Created by Khaled Abo hassob on 18/2/2024.
//

import Foundation

protocol RateMovieViewModelProtocol: AnyObject {
    func getMovieDetails() -> PopularResults
}

class RateMovieViewModel {
    private weak var view: RateMovieVCProtocol?
    private var result: PopularResults?
    
    // MARK: - Init
    init(view: RateMovieVCProtocol?, result: PopularResults?) {
        self.view = view
        self.result = result
    }
}

extension RateMovieViewModel: RateMovieViewModelProtocol {
    func getMovieDetails() -> PopularResults {
        return result!
    }
}
