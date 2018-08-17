//
//  testVC.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/17/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import UIKit

class testVC: UIViewController {

    @IBOutlet weak var imageTest: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        AuthService.instance.saveUserInSessionManager(Mail: "tttttt@gmail.com")
        guard let imageData = UIImage(data: SessionManager.session.picture!) else { print("erreur"); return }
       imageTest.image = imageData
    }
    


}
