//
//  RateMovieVC.swift
//  AppChallenege
//
//  Created by Khaled Abo hassob on 18/2/2024.
//

import UIKit
import SDWebImage

protocol RateMovieVCProtocol: AnyObject {
    
}

class RateMovieVC: UIViewController {

    // MARK: - Properties
    private var viewModel: RateMovieViewModel!
    
    private var posterImgView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.backgroundColor = .red
        return image
    }()
    
    private var posterLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: Fonts.jomhuriaFont, size: 96)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Paw Patrol"
        return label
    }()
    
    var movieImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.borderWidth = 6
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 40
        image.layer.maskedCorners = [.layerMaxXMinYCorner]
        image.layoutIfNeeded()
        image.layer.borderColor = UIColor.white.cgColor
        return image
    }()
    
    private var rateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: Fonts.jomhuriaFont, size: 30)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "You rated this"
        return label
    }()
    
    
    var resetRatingButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Component 4"), for: .normal)
        return button
    }()
    
    var addToFavoriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "fav"), for: .normal)
        return button
    }()
    
    var goToFavoriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go to favourites", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.interRegular, size: 16)
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        return button
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        goToFavoriteButton.addTarget(self, action: #selector(goToFavPressed), for: .touchUpInside)
        setupDate()
        view.backgroundColor = UIColor(hex: "A5E8B4", alpha: 1)
        view.addSubview(posterImgView)
        view.addSubview(posterLabel)
        view.addSubview(rateLabel)
        view.addSubview(movieImageView)
        view.addSubview(addToFavoriteButton)
        view.addSubview(resetRatingButton)
        view.addSubview(goToFavoriteButton)
        backButtonCustomization()
        addConstraints()
    }
    
    // MARK: - Public Methods
    class func create(movie: PopularResults) -> RateMovieVC {
        let rateMovieVC: RateMovieVC = RateMovieVC()
        rateMovieVC.viewModel = RateMovieViewModel(view: rateMovieVC, result: movie)
        return rateMovieVC
    }
    
    @objc func goToFavPressed() {
//        let vc = MyFavVC.create(movie: self.viewModel.getMovieDetails())
//        self.navigationController?.pushViewController(vc, animated: true)
        print("Coming soon.")
    }
}

// MARK: - Private Methods
extension RateMovieVC {
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // posterImageView
        constraints.append(posterImgView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0))
        constraints.append(posterImgView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0))
        constraints.append(posterImgView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0))
        constraints.append(posterImgView.heightAnchor.constraint(equalToConstant: 448))
        
        // posterLabel
        constraints.append(posterLabel.topAnchor.constraint(equalTo: self.posterImgView.topAnchor, constant: 90))
        constraints.append(posterLabel.leadingAnchor.constraint(equalTo: self.posterImgView.leadingAnchor, constant: 32))
        constraints.append(posterLabel.trailingAnchor.constraint(equalTo: self.posterImgView.trailingAnchor, constant: 18))
        constraints.append(posterLabel.heightAnchor.constraint(equalToConstant: 96))
        
        // rateLabel
        constraints.append(rateLabel.topAnchor.constraint(equalTo: posterLabel.bottomAnchor, constant: -5))
        constraints.append(rateLabel.leadingAnchor.constraint(equalTo: posterLabel.leadingAnchor, constant: 0))
        constraints.append(rateLabel.trailingAnchor.constraint(equalTo: posterLabel.trailingAnchor, constant: 0))
        constraints.append(rateLabel.heightAnchor.constraint(equalToConstant: 30))
        
        // movieImgView
        constraints.append(movieImageView.topAnchor.constraint(equalTo: posterImgView.topAnchor, constant: 351))
        constraints.append(movieImageView.heightAnchor.constraint(equalToConstant: 162))
        constraints.append(movieImageView.leadingAnchor.constraint(equalTo: posterImgView.leadingAnchor, constant: 125))
        constraints.append(movieImageView.trailingAnchor.constraint(equalTo: posterImgView.trailingAnchor, constant: -148))
        
        // addToFavoriteButton
        constraints.append(addToFavoriteButton.leadingAnchor.constraint(equalTo: self.movieImageView.trailingAnchor, constant: -4))
        constraints.append(addToFavoriteButton.topAnchor.constraint(equalTo: self.movieImageView.topAnchor, constant: -38))
        constraints.append(addToFavoriteButton.widthAnchor.constraint(equalToConstant: 48))
        constraints.append(addToFavoriteButton.heightAnchor.constraint(equalToConstant: 48))
        
      
        
        // goToFavoriteButton
        constraints.append(goToFavoriteButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -170))
        constraints.append(goToFavoriteButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50))
        constraints.append(goToFavoriteButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -66))
        constraints.append(goToFavoriteButton.heightAnchor.constraint(equalToConstant: 56))
        
        
        constraints.append(resetRatingButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 114))
        constraints.append(resetRatingButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -129))
        constraints.append(resetRatingButton.bottomAnchor.constraint(equalTo: self.goToFavoriteButton.topAnchor, constant: -27))
        constraints.append(resetRatingButton.heightAnchor.constraint(equalToConstant: 56))
        
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
        posterLabel.text = "\(viewModel.getMovieDetails().original_title ?? "")"
        posterImgView.sd_setImage(with: URL(string: URLs.imageURL + (self.viewModel.getMovieDetails().poster_path ?? "")))
        movieImageView.sd_setImage(with: URL(string: URLs.imageURL + (self.viewModel.getMovieDetails().backdrop_path ?? "")))
    }
}

// MARK: - RateMovieVC Protocol
extension RateMovieVC: RateMovieVCProtocol {
    
}
