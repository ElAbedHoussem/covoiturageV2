//
//  SearchCircuitVCViewController.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/6/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import UIKit

class SearchCircuitVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // this three lignes make navigation from the current ViewController to the menu is possible
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }

   

}
