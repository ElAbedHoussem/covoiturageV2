//
//  UIViewExtension.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/28/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import Foundation
extension UIView {
    func roundedViewCell(){
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        //self.layer.borderColor = UIColor.gray.cgColor
        //self.layer.borderWidth = 0.5
    }
}
