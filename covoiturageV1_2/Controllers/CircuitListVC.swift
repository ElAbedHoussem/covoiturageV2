//
//  CircuitListVC.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/2/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import UIKit

class CircuitListVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())

        
    }

}
