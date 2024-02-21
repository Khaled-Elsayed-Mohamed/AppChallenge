//
//  TableViewCell.swift
//  AppChallenege
//
//  Created by Khaled Abo hassob on 18/2/2024.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    var genreLabel:UILabel = {
        let label = UILabel(frame: CGRect(x:100, y: 30, width: UIScreen.main.bounds.width , height: 15))

        label.font = UIFont(name: Fonts.interRegular, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
               super.init(frame: frame)
        genreLabel.frame = contentView.bounds
        self.contentView.addSubview(self.genreLabel)
        genreLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        genreLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        genreLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
           }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ item: PopularResults) {
        self.genreLabel.text = item.original_title
    }
    
}

