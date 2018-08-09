//
//  File.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/7/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import Foundation
import FirebaseCore
import  FirebaseAuth
import FirebaseDatabase
import Firebase
class  AuthService {
    static let instance  = AuthService()
    
    func registerUser(withEmail email: String , andPassword password: String,firstName :String, lastName : String , age :Int, phoneNumber : Double, picture : UIImageView, userCreationComplete: @escaping(_ status: Bool, _ error: Error?) ->()){

        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else{
                userCreationComplete(false,error)
                return
        }
        /*Auth.auth().createUser(withEmail: email, password: password){ (user, error) in
            guard let user = user else{
                userCreationComplete(false,error)
                return
            }*/
            let userData =  ["provider": user.user.providerID, "mail": user.user.email]
            DataService.instance.createDBUser(uid: user.user.providerID, userData: userData)
            userCreationComplete(true, nil)


            
            
        }
    }
    
    
    func loginUser(withEmail email: String , andPassword password: String, loginComplete: @escaping(_ status: Bool, _ error: Error?) ->()){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                    loginComplete(false,error)
                return
            }
            loginComplete(true,nil)
        }
    }
}
