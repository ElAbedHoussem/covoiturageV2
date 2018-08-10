//
//  MenuView.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/6/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import UIKit
@IBDesignable
class MenuView: UIView {

    //this class help us the make the menu Dessign 
    @IBInspectable var topColor = UIColor.blue {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor = UIColor.white{
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let menuLayer = CAGradientLayer()
        menuLayer.colors = [ topColor.cgColor , bottomColor.cgColor]
        menuLayer.startPoint = CGPoint (x: 0, y: 0)
        menuLayer.endPoint = CGPoint (x:1 , y: 1 )
        menuLayer.frame = self.bounds
        self.layer.insertSublayer(menuLayer, at: 0)
    }

}
