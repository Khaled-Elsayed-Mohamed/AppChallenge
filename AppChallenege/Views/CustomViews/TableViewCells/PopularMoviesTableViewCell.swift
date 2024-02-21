//
//  TableViewCell.swift
//  AppChallenege
//
//  Created by Khaled Abo hassob on 18/2/2024.
//

import UIKit
import SDWebImage

class PopularMoviesTableViewCell: UITableViewCell {
    
    // MARK:- Properties
    private var viewModel:PopularMoviesViewModelProtocol!
    
    var genre: [GenreData] = []
    
    // Mark:- UI
     var genreCollectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
          cv.translatesAutoresizingMaskIntoConstraints = false
//          cv.backgroundColor = UIColor.red
          return cv
      }()
    
    var posterImageView:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 8
        image.backgroundColor = .black
        return image
    }()
    var titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.interBold, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    var yearLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.interRegular, size: 12)
        label.textColor = Colors.yearLabelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    var ratingPercentageLabel:UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: Fonts.interBold, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    var userScoreLabel:UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.genreCollectionView.delegate = self
        self.genreCollectionView.dataSource = self
        genreCollectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        genreCollectionView.showsHorizontalScrollIndicator = false
        genreCollectionView.isScrollEnabled = true
        contentView.addSubview(genreCollectionView)
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(yearLabel)
        addSubview(ratingPercentageLabel)
        addSubview(userScoreLabel)
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
//    func reset(with _cellData: String) {
////         self.data = cellData
//        genrsCollectionsView.dataSource = self
//        genrsCollectionsView.delegate = self
//        genrsCollectionsView.reloadData()
//    }
    

    
    private func addConstraints() {
        posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24).isActive = true
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 85).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 131).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 27).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 51).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        yearLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 27).isActive = true
        yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        yearLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        ratingPercentageLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 27).isActive = true
        ratingPercentageLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 5).isActive = true
        ratingPercentageLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        userScoreLabel.leadingAnchor.constraint(equalTo: ratingPercentageLabel.trailingAnchor, constant: 8).isActive = true
        userScoreLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 5).isActive = true
        userScoreLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        genreCollectionView.topAnchor.constraint(equalTo: userScoreLabel.bottomAnchor, constant: 5).isActive = true
//        genreCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        genreCollectionView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 27).isActive = true
//        genreCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        genreCollectionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        genreCollectionView.widthAnchor.constraint(equalToConstant: self.contentView.frame.width / 1.5).isActive = true
    }
    
    func configureCell(_ item: PopularResults) {
        self.titleLabel.text = item.original_title
        self.yearLabel.text = item.release_date
        self.ratingPercentageLabel.text = "\(Int((item.vote_average ?? 0.0) * 10))%"
        self.posterImageView.sd_setImage(with: URL(string: URLs.imageURL + (item.poster_path ?? "")))
        
    }
    
}


extension PopularMoviesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    func updateCellWith(row: String) {
////          self.genre = ["Action", "drama"]
//          self.genreCollectionsView.reloadData()
//      }
//      
//     func numberOfSections(in collectionView: UICollectionView) -> Int {
//            return 1
//        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("SSSSSSS")
        print(genreCollectionView.frame.height, "okayz")
        return genre.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GenreCollectionViewCell
        cell.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        cell.genreLabel.text = genre[indexPath.item].name
        cell.genreLabel.textColor = UIColor(red: 149/255, green: 149/255, blue: 149/255, alpha: 1)
        cell.roundCorners(corners: .allCorners, radius: 9)
        print(cell.backgroundColor, "gggggg")

//          cell.genreLabel.text = "dsad"
        return cell
    }


//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let text = NSAttributedString(string: genre[indexPath.row])
//        return CGSize(width: text.size().width, height: 21)
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt  section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
  

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (genre[indexPath.item].name ?? "").size(withAttributes: [NSAttributedString.Key.font: UIFont(name: Fonts.interBold, size: 16) ?? UIFont()]).width + 25
        
        return CGSize(width: width, height: 20)
    }

}
    


