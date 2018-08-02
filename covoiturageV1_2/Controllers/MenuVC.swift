//
//  MenuVC.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/2/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }

   
}
