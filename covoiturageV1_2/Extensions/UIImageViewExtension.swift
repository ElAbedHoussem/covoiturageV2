//
//  UIImageViewExtension.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/26/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import Foundation
extension UIImageView{

    func roundedImage(){
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 4
    }

}
