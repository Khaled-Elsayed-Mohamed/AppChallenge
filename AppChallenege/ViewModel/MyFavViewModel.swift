//
//  RateMovieViewModel.swift
//  AppChallenege
//
//  Created by Khaled Abo hassob on 20/2/2024.
//

import Foundation

protocol MyFavViewModelProtocol: AnyObject {
    func getMovieDetails() -> PopularResults
}

class MyFavViewModel {
    private weak var view: MyFavVCProtocol?
    private var result: PopularResults?  // (! FAV Results HERE !)
    
    // MARK: - Init
    init(view: MyFavVCProtocol?, result: PopularResults?) {
        self.view = view
        self.result = result
    }
}

extension MyFavViewModel: MyFavViewModelProtocol {
    func getMovieDetails() -> PopularResults {
        return result!
    }
}
