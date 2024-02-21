//
//  MovieDetailsVC.swift
//  AppChallenege
//
//  Created by Khaled Abo hassob on 18/2/2024.
//

import UIKit
import GTProgressBar

protocol MovieDetailsVCProtocol: AnyObject {
    
}

class MovieDetailsVC: UIViewController {
    
    private var viewModel: MovieDetailsViewModel!
    var overviewDescriptionTextView: UITextView = {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 0, height: 265))
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.isSelectable = true
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()
    
    private var viewFavoritsButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 145, height: 56))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hex: "FFF3D3")
        button.setTitle("View Favs", for: .normal)
        button.setTitleColor(UIColor(red: 185/250, green: 142/250, blue: 30/250, alpha: 1),for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont(name: Fonts.interRegular, size: 16)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private var rateItButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 56))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Component 3"), for: .normal)
        button.titleLabel?.lineBreakMode = .byCharWrapping
        button.layer.cornerRadius = 20
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: Fonts.interRegular, size: 16)
        return button
    }()
    
    private var overviewLabel:UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 165, height: 18))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Overview"
        label.font = UIFont(name: Fonts.interBold, size: 16)
        return label
    }()
    
    private var posterLabel:UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 252, height: 100))
        label.font = UIFont(name: Fonts.jomhuriaFont, size: 96)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    var posterImageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 393, height: 100))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 8
        image.backgroundColor = .black
        
        return image
    }()
    
    var movieImageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 125, height: 167))
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
    
    var addToFavoriteButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "fav"), for: .normal)
        return button
    }()
    
    private var movieTitleLabel:UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 165, height: 18))
        label.font = UIFont(name: Fonts.interBold, size: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private var yearLabel:UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 165, height: 18))
        label.text = "2023"
        label.textColor = UIColor(hex: "959595")
        label.font = UIFont(name: Fonts.interRegular, size: 12)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var categoryLabel:UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 165, height: 18))
        label.text = "Animation  Family"
        label.textColor = UIColor(hex: "959595")
        label.font = UIFont(name: Fonts.interRegular, size: 12)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var scorePercentageLabel:UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        label.font = UIFont(name: Fonts.interBold, size: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private var userScoreLabel:UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 18))
        label.text = "user score"
        label.font = UIFont(name: Fonts.interRegular, size: 12)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private var progressBar: GTProgressBar = {
        let progressBar = GTProgressBar(frame: .zero)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.progress = 0
        progressBar.barFillColor = UIColor(red:76/255, green:171/255, blue:74/255, alpha:1.0)
        progressBar.barBackgroundColor = UIColor(red:210/255, green:210/255, blue:210/255, alpha:1.0)
        progressBar.barFillInset = 0
        progressBar.barBorderColor = .clear
        progressBar.barBorderWidth = 0
        progressBar.displayLabel = false
        progressBar.cornerType = .square
        return progressBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rateItButton.addTarget(self, action: #selector(rateBtnPressed), for: .touchUpInside)
        view.addSubview(overviewDescriptionTextView)
        view.addSubview(viewFavoritsButton)
        view.addSubview(rateItButton)
        view.addSubview(posterImageView)
        view.addSubview(posterLabel)
        view.addSubview(addToFavoriteButton)
        view.addSubview(movieTitleLabel)
        view.addSubview(yearLabel)
        view.addSubview(categoryLabel)
        view.addSubview(scorePercentageLabel)
        view.addSubview(userScoreLabel)
        view.addSubview(overviewLabel)
        view.addSubview(movieImageView)
        view.addSubview(progressBar)
        view.backgroundColor = .white
        backButtonCustomization()
        addConstraints()
        setupUI()
    }
    
    // MARK: - Puplic Methods
    class func create(movie: PopularResults) -> MovieDetailsVC {
        let movieDetailsVC: MovieDetailsVC = MovieDetailsVC()
        movieDetailsVC.viewModel = MovieDetailsViewModel(view: movieDetailsVC, result: movie)
        return movieDetailsVC
    }
    
    @objc func rateBtnPressed() {
        let vc = RateMovieVC.create(movie: self.viewModel.setMovie())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupUI() {
        overviewDescriptionTextView.text = viewModel.setMovie().overview
        scorePercentageLabel.text = "\(Int((viewModel.setMovie().vote_average ?? 0) * 10))%"
        movieTitleLabel.text = "\(viewModel.setMovie().original_title ?? "")"
        posterLabel.text = "\(viewModel.setMovie().original_title ?? "")"
        yearLabel.text = "\(viewModel.setMovie().release_date ?? "")"
        progressBar.progress = CGFloat(Float((viewModel.setMovie().vote_average ?? 0.0) / 10))
        print(CGFloat(viewModel.setMovie().vote_average ?? 0), "sdad")
        
        
        self.viewModel.downloadImage(with: self.viewModel.setMovie(), imageURL: URL(string: URLs.imageURL + (self.viewModel.setMovie().poster_path ?? "")) ?? URL(fileURLWithPath: "")) { result in
            print(URL(string: URLs.imageURL + (self.viewModel.setMovie().poster_path ?? "")) ?? URL(fileURLWithPath: ""), "posterPathhh")
            self.movieImageView.image = result
        }
        
        self.viewModel.downloadImage(with: self.viewModel.setMovie(), imageURL: URL(string: URLs.imageURL + (self.viewModel.setMovie().backdrop_path ?? "")) ?? URL(fileURLWithPath: "")) { result in
            print(URL(string: URLs.imageURL + (self.viewModel.setMovie().backdrop_path ?? "")) ?? URL(fileURLWithPath: ""), "Backdroop")
            self.posterImageView.image = result
        }
        
    }
    
    func backButtonCustomization() {
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "back"), for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal)
        backbutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }
    
    
    
    @objc func backAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension MovieDetailsVC {
    // Mark:- private functions
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // posterImageView
        constraints.append(posterImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0))
        constraints.append(posterImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0))
        constraints.append(posterImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0))
        constraints.append(posterImageView.heightAnchor.constraint(equalToConstant: 263))
        
        
        // movieImageView
        constraints.append(movieImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 37))
        constraints.append(movieImageView.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor, constant: -50))
        constraints.append(movieImageView.heightAnchor.constraint(equalToConstant: 167))
        constraints.append(movieImageView.widthAnchor.constraint(equalToConstant: 125))
        
        // posterLabel
        constraints.append(posterLabel.topAnchor.constraint(equalTo: self.posterImageView.topAnchor, constant: 90))
        constraints.append(posterLabel.leadingAnchor.constraint(equalTo: self.posterImageView.leadingAnchor, constant: 32))
        constraints.append(posterLabel.heightAnchor.constraint(equalToConstant: 96))
        
        // addToFavoriteButton
        constraints.append(addToFavoriteButton.leadingAnchor.constraint(equalTo: self.movieImageView.trailingAnchor, constant: -4))
        constraints.append(addToFavoriteButton.topAnchor.constraint(equalTo: self.movieImageView.topAnchor, constant: -38))
        
        
        // movieTitleLabel
        constraints.append(movieTitleLabel.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor, constant: 6))
        constraints.append(movieTitleLabel.leadingAnchor.constraint(equalTo: self.movieImageView.trailingAnchor, constant: 20))
        
        
        // yearLAbel
        constraints.append(yearLabel.topAnchor.constraint(equalTo: self.movieTitleLabel.bottomAnchor, constant: 5))
        constraints.append(yearLabel.leadingAnchor.constraint(equalTo: self.movieTitleLabel.leadingAnchor, constant: 0))
        
        // categoryLabel
        constraints.append(categoryLabel.topAnchor.constraint(equalTo: self.yearLabel.bottomAnchor, constant: 4))
        constraints.append(categoryLabel.leadingAnchor.constraint(equalTo: self.movieTitleLabel.leadingAnchor, constant: 0))
        
        // scorePercentageLabel
        constraints.append(scorePercentageLabel.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 5))
        constraints.append(scorePercentageLabel.leadingAnchor.constraint(equalTo: self.movieTitleLabel.leadingAnchor, constant: 0))
        constraints.append(scorePercentageLabel.trailingAnchor.constraint(equalTo: self.userScoreLabel.leadingAnchor, constant: -17))
        
        // userscoreLabel
        constraints.append(userScoreLabel.centerYAnchor.constraint(equalTo: scorePercentageLabel.centerYAnchor))
        constraints.append(userScoreLabel.leadingAnchor.constraint(equalTo: scorePercentageLabel.trailingAnchor, constant: 17))
        
        // progressBar
        constraints.append(progressBar.topAnchor.constraint(equalTo: scorePercentageLabel.bottomAnchor, constant: 5))
        constraints.append(progressBar.leadingAnchor.constraint(equalTo: scorePercentageLabel.leadingAnchor, constant: 0))
        constraints.append(progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50))
        constraints.append(progressBar.heightAnchor.constraint(equalToConstant: 4))
        
        // rateItButton
        constraints.append(rateItButton.topAnchor.constraint(equalTo: self.movieImageView.bottomAnchor, constant: 27))
        constraints.append(rateItButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 37))
        constraints.append(rateItButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 150))
        constraints.append(rateItButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 56))
        constraints.append(rateItButton.trailingAnchor.constraint(equalTo: self.viewFavoritsButton.leadingAnchor, constant: -10))
        
        // viewFavoritsButton
        constraints.append(viewFavoritsButton.topAnchor.constraint(equalTo: self.rateItButton.topAnchor, constant: 0))
        constraints.append(viewFavoritsButton.leadingAnchor.constraint(equalTo: self.rateItButton.trailingAnchor, constant: 10))
        constraints.append(viewFavoritsButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 150))
        constraints.append(viewFavoritsButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 56))
        
        // overviewLabel
        constraints.append(overviewLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 37))
        constraints.append(overviewLabel.topAnchor.constraint(equalTo: self.rateItButton.bottomAnchor, constant: 14))
        
        // overviewDescriptionLabel
        constraints.append(overviewDescriptionTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 37))
        constraints.append(overviewDescriptionTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -37))
        constraints.append(overviewDescriptionTextView.topAnchor.constraint(equalTo: self.overviewLabel.bottomAnchor, constant: 14))
        constraints.append(overviewDescriptionTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 40))
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension MovieDetailsVC: MovieDetailsVCProtocol {
    
}
