//
//  UIColor+Gradient.swift
//  AppChallenege
//
//  Created by Khaled Abo hassob on 20/2/2024.
//


import UIKit

extension CAGradientLayer {

    func backgroundGradientColor() -> CAGradientLayer {
        let topColor = UIColor(hex: "FFFFF")
        let bottomColor = UIColor(hex: "EEEEE")

        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [NSNumber] = [0.0, 1.0]

        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations

        return gradientLayer

    }
}
