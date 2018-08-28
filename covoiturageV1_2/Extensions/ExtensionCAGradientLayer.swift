//
//  ExtensionCAGradientLayer.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/28/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import Foundation
extension CAGradientLayer{
    func createGradientLayer() {
        var gradientLayer = CAGradientLayer()

        gradientLayer.frame = self.view.bounds

        gradientLayer.colors = [UIColor.redColor().CGColor, UIColor.yellowColor().CGColor]

        self.view.layer.addSublayer(gradientLayer)
    }
}
