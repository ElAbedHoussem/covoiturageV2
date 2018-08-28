//
//  UIViewExtension.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/28/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import Foundation
extension UIView {
//    func roundedViewCell(){
//
//        self.layer.cornerRadius = 20
//        self.clipsToBounds = true
//    }
    func roundedPricePersonViewCell(){
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    func roundedViewCell(cornerRadius: Double) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
