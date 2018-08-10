//
//  FirstVC.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/1/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //send the user to the Authentification View Controller
    @IBAction func onAuthPressed(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let authVC = mainStoryBoard.instantiateViewController(withIdentifier: "AuthVC") as! AuthVC
        self.navigationController?.pushViewController(authVC, animated: true)
    }
   //send the user to the Inscription View Controller
    @IBAction func onIscriptionPressed(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let inscriptionVC = mainStoryBoard.instantiateViewController(withIdentifier: "InscriptionVC") as! InscriptionVC
        self.navigationController?.pushViewController(inscriptionVC, animated: true)
    }
    
    
   

}
