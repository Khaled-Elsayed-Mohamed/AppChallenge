//
//  UIColors.swift
//  AppChallenege
//
//  Created by Khaled Abo hassob on 17/2/2024.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

struct Colors {
    static let PopularMoviesBackgroundColor = UIColor(hex: "8EEAA2")
    static let PopularMoviesColorFont = UIColor(hex: "347868")
    static let MovieTitleColorFont = UIColor(hex: "FFFFF")
    static let yearLabelColor = UIColor(hex: "959595")
}
