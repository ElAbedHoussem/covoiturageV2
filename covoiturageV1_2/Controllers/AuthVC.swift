//
//  AuthVC.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/1/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import UIKit
import FirebaseAuth
import FacebookCore
import FacebookLogin
import FirebaseStorage
import FirebaseDatabase

class AuthVC: UIViewController  {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //in the Auth View controller when we press on the connexion  button , if all Field text are not empty, then we can call loginUser method
    // if the user existe and we have the good mail and password then we send him th CircuitList View Controller ( SWRevalViewController
    @IBAction func onConnectionPressed(_ sender: UIButton) {
        if (emailTextField.text != nil && passwordTextField.text != nil) {
            AuthService.instance.loginUser(withEmail: emailTextField.text!, andPassword: passwordTextField.text!, loginComplete: { (succes, loginError) in
                if succes{

                    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                    let swRevealViewController = mainStoryBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                    self.navigationController?.pushViewController(swRevealViewController, animated: true)

                }
                else{
                    print (String(describing: loginError?.localizedDescription))
                }
            })
        }
       
    }
    


    //not used for the moment

    @objc func handleSignInWithFacebookButtonTapped() {
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { (result) in
            switch result {
            case .success(grantedPermissions: _, declinedPermissions: _, token: _):
                print("Succesfully logged in into Facebook.")
                self.signIntoFirebase()
            case .failed(let err):
                print(err.localizedDescription)
            case .cancelled:
                print("Canceled getting Facebook user.")
            }
        }
    }
    
    //not used for the moment
    fileprivate func signIntoFirebase() {
        guard let authenticationToken = AccessToken.current?.authenticationToken else { return }
        let credential = FacebookAuthProvider.credential(withAccessToken: authenticationToken)
        Auth.auth().signIn(with: credential) { (user, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            print("Succesfully authenticated with Firebase.")
            //self.fetchFacebookUser()
        }
    }
    
    
    

    


}
