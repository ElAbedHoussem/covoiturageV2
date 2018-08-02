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

    @IBAction func onAuthPressed(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let authVC = mainStoryBoard.instantiateViewController(withIdentifier: "AuthVC") as! AuthVC
        self.navigationController?.pushViewController(authVC, animated: true)
    }
    @IBAction func onInscriptionPressed(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let inscriptionVC = mainStoryBoard.instantiateViewController(withIdentifier: "inscri") as! InscriptionVC
        self.navigationController?.pushViewController(inscriptionVC, animated: true)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
