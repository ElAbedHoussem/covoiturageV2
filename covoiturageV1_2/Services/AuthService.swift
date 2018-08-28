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

    func registerUser(withEmail email: String , andPassword password: String,firstName :String, lastName : String , phoneNumber : String ,age : String , picture :UIImageView, userCreationComplete: @escaping(_ status: Bool, _ error: Error?) ->()){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else{
                userCreationComplete(false,error)
                return
        }
            var image = Data()
            image = UIImagePNGRepresentation(picture.image!)!
            DataService.instance.createUser(email: email, password: password, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber,age : age, picture: image)
            userCreationComplete(true, nil)
        }
    }

    func loginUser(withEmail email: String , andPassword password: String, loginComplete: @escaping(_ status: Bool, _ error: Error?) ->()){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                    loginComplete(false,error)
                return
            }else{
                print("connexion avec succes")
                self.saveUserInSessionManager(Mail: email, Password: password)
                loginComplete(true,nil)
            }
        }
    }

    func  saveUserInSessionManager(Mail : String , Password : String) -> () {
        let ref_db = Database.database().reference(withPath: "users")
        let ref_storage = Storage.storage()
        ref_db.observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() { return }
            let Usersdictionnary = snapshot.value as? [String: AnyObject]
            for (Userkey, UserInfo) in Usersdictionnary! {
                if ((UserInfo["email"] as! String) == Mail && (UserInfo["password"] as! String) == Password ){
                    SessionManager.session.email = UserInfo["email"] as! String
                    SessionManager.session.userID = UserInfo["userID"] as! String
                    SessionManager.session.password = UserInfo["password"] as! String
                    SessionManager.session.age = UserInfo["age"] as! String
                    SessionManager.session.userID = UserInfo["userID"] as! String
                    SessionManager.session.lastName = UserInfo["lastName"] as! String
                    SessionManager.session.firstNsame = UserInfo["firstName"] as! String
                    SessionManager.session.phoneNumber = UserInfo["phoneNumber"]  as! String
                    var pathDirectory = "images/"
                    /*
                    if let filePath = SessionManager.session.userID {
                        ref_storage.reference().child(pathDirectory+filePath).getData(maxSize: 10*1024*2048, completion: { (data, error) in
                        if error == nil{
                            SessionManager.session.picture = data
                            print("dans AuthService , saveUserInSessionManager , imagepath = \(pathDirectory+filePath)")
                        }else{
                            print(error)
                        }
                    })
                    }
                    */
                    break
                }
            }
        })
    }

    func  saveUserInSessionManager(Mail : String ) {
        let ref = Database.database().reference(withPath: "users")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() { return }
            let Usersdictionnary = snapshot.value as? [String: AnyObject]
            for (Userkey, UserInfo) in Usersdictionnary! {
                if ((UserInfo["email"] as! String) == Mail){

                }
            }
        })
    }

    func getUserFromSessionManager() -> [String:Any?] {

        return ["userID" : SessionManager.session.userID ?? ""  ,"firstName" : SessionManager.session.firstNsame ?? "" , "lastName" : SessionManager.session.lastName ?? "" ,
                "age" : SessionManager.session.age ?? "" ,"phoneNumber" : SessionManager.session.phoneNumber ?? "" , "email" : SessionManager.session.email ?? "" ,
                "password" : SessionManager.session.password ?? "" ]
    }

    func getIDDriverFromSessionManager() -> String{
        return SessionManager.session.userID ?? ""
    }

    func getUserFromSessionManager() -> String{
        return SessionManager.session.userID ?? ""
    }





}
