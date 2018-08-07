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

    @IBAction func onListAdvertsPressed(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let listAdvertsVC = mainStoryBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        self.navigationController?.pushViewController(listAdvertsVC, animated: true)
    }
    
    
    @IBAction func onSearchCircuitPressed(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let searchCircuitVC = mainStoryBoard.instantiateViewController(withIdentifier: "SWRevealViewControllerSearch") as! SWRevealViewController
        self.navigationController?.pushViewController(searchCircuitVC, animated: true)
    }
    
    
    @IBAction func onPostCircuitPressed(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let postCircuitVC = mainStoryBoard.instantiateViewController(withIdentifier: "SWRevealViewControllerAdd") as! SWRevealViewController
        self.navigationController?.pushViewController(postCircuitVC, animated: true)
    }
   
}
