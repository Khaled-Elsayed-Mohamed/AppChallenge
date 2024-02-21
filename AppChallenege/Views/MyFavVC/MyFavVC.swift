//
//  RateMovieViewModel.swift
//  AppChallenege
//
//  Created by Khaled Abo hassob on 20/2/2024.
//

import UIKit

protocol MyFavVCProtocol: AnyObject {
    
}

class MyFavVC: UIViewController {

    private var viewModel: MyFavViewModel!

    private var myFavLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 323, height: 96))
        label.text = "My favourites"
        label.textColor = UIColor(hex: "347868")
        label.font = UIFont(name: Fonts.jomhuriaFont, size: 96)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var favCollectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
         cv.translatesAutoresizingMaskIntoConstraints = false
//          cv.backgroundColor = UIColor.red
         return cv
     }()
    
    var searchForMoreButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 269, height: 56))
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Search for More", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.interRegular, size: 16)
        button.backgroundColor =  UIColor(hex: "EFEFEF")
        button.layer.cornerRadius = 80
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor =  UIColor(hex: "8EEAA2", alpha: 1)
        setupDate()
        view.backgroundColor = .white
//        self.favCollectionView.delegate = self
//        self.favCollectionView.dataSource = self
//        favCollectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
//        favCollectionView.showsHorizontalScrollIndicator = false
//        favCollectionView.isScrollEnabled = true
        view.addSubview(myFavLabel)
        view.addSubview(favCollectionView)
        view.addSubview(searchForMoreButton)
        backButtonCustomization()
        addConstraints()


    }
    
    // MARK: - Public Methods
    class func create(movie: PopularResults) -> MyFavVC {
        let myFavVC: MyFavVC = MyFavVC()
        myFavVC.viewModel = MyFavViewModel(view: myFavVC, result: movie)
        return myFavVC
    }
    
}

// MARK: - Private Methods
extension MyFavVC {
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // posterImageView
        constraints.append(myFavLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35))
        constraints.append(myFavLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 119))
        
        // posterLabel
        constraints.append(favCollectionView.topAnchor.constraint(equalTo: self.myFavLabel.bottomAnchor, constant: 5))
        constraints.append(favCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 26))
        constraints.append(favCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0))
        constraints.append(favCollectionView.heightAnchor.constraint(equalToConstant: 245))
        constraints.append(favCollectionView.widthAnchor.constraint(equalToConstant: 367))
        

        // goToFavoriteButton
        constraints.append(searchForMoreButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 99))
        constraints.append(searchForMoreButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 63))
     
        constraints.append(searchForMoreButton.heightAnchor.constraint(equalToConstant: 56))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func backButtonCustomization() {
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "back"), for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal)
        backbutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }
    
    @objc func backAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupDate() {
        favCollectionView.backgroundColor = .blue
        
        
        
//        posterLabel.text = "\(viewModel.getMovieDetails().original_title ?? "")"
//        posterImgView.sd_setImage(with: URL(string: URLs.imageURL + (self.viewModel.getMovieDetails().poster_path ?? "")))
//        movieImageView.sd_setImage(with: URL(string: URLs.imageURL + (self.viewModel.getMovieDetails().backdrop_path ?? "")))
    }
}


extension MyFavVC: MyFavVCProtocol {
    
    
}

//extension MyFavVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//}
