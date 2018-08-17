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
    //this method make possible to go to the CircuitList View Controller
    @IBAction func onListAdvertsPressed(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let listAdvertsVC = mainStoryBoard.instantiateViewController(withIdentifier: "CircuitListVC") as! CircuitListVC
        self.navigationController?.pushViewController(listAdvertsVC, animated: true)
    }
    
    //this method make possible to go to the SearchCircuitVC View Controller
    @IBAction func onSearchCircuitPressed(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let searchCircuitVC = mainStoryBoard.instantiateViewController(withIdentifier: "SearchCircuitVC") as! SearchCircuitVC
        self.navigationController?.pushViewController(searchCircuitVC, animated: true)
    }
    
        //this method make possible to go to the AddACircuit View Controller
    @IBAction func onPostCircuitPressed(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let postCircuitVC = mainStoryBoard.instantiateViewController(withIdentifier: "AddACircuitVC") as! AddACircuitVC
        self.navigationController?.pushViewController(postCircuitVC, animated: true)
    }
   
}
