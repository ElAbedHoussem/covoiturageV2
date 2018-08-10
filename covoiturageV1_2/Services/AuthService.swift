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





    // th registerUser method is called to save th user informations in firebase
    func registerUser(withEmail email: String , andPassword password: String,firstName :String, lastName : String , phoneNumber : Double ,age : Int , picture :UIImageView, userCreationComplete: @escaping(_ status: Bool, _ error: Error?) ->()){
        //this method is from FirebaseAuth library , she save the user as a firebase user
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else{
                userCreationComplete(false,error)
                return
        }
            //create an Data object to save the image
            var image = Data()
            //convert  the UIImage to PNG
            image = UIImagePNGRepresentation(picture.image!)!
            //the createUser method save data in Firebase/Database
            DataService.instance.createUser(email: email, password: password, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber,age : age, picture: image)
            userCreationComplete(true, nil)


            
            
        }
    }
    
    //loginUser method asure the Auth for a specific email an password in Firebase
    func loginUser(withEmail email: String , andPassword password: String, loginComplete: @escaping(_ status: Bool, _ error: Error?) ->()){
        // Auth.auth.signIn help us to asure th Auth
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                    loginComplete(false,error)
                return
            }
            print("connexion avec succes")
            //getUser method retrive all information of an specific mail an save in the user.Default
            self.getUser(Mail: email, Password: password)
            loginComplete(true,nil)
        }
    }



    //getUser search all the information about an specific mail  , retrive them and save in user.Default
    func  getUser(Mail : String , Password : String) -> () {
        //retriving data from document user
        let ref = Database.database().reference(withPath: "users")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() { return }
            //print(snapshot.value!)


            //casting snapshot ot a dictionary
            let Usersdictionnary = snapshot.value as? [String: AnyObject]
            //print("le contenu de dictionnaire est :")
            //print(Usersdictionnary)

            print("***********")
            for (var Userkey, var UserInfo) in Usersdictionnary! {
                print(Userkey)
                var UserDetails  = UserInfo as?[String : AnyObject]
                //if we are in the  right user
                if ((UserDetails!["email"] as? String) == Mail && (UserDetails!["password"]as? String) == Password){


                    //save user infromation in user.Default
                    //****Begin ******//
                    let arrayOfUsers = UserDefaults.standard.object(forKey: "currentUser")
                    if var array = arrayOfUsers as? [[String:String]]{
                        let user = ["userID" : UserDetails!["userID"],"email" : UserDetails!["email"], "firstName" : UserDetails!["firstName"],
                                    "lastName" : UserDetails!["lastName"], "password" :UserDetails!["password"] ,"phoneNumber" : UserDetails!["phoneNumber"] , "age" : UserDetails!["age"]
                        ];
                        array.append(user as! [String : String])
                        UserDefaults.standard.set(array, forKey:"currentUser")
                    }
                    else{
                        var array:[[String:String]] = [[:]]
                        let user = ["userID" : UserDetails!["userID"],"email" : UserDetails!["email"], "firstName" : UserDetails!["firstName"],
                                    "lastName" : UserDetails!["lastName"], "password" :UserDetails!["password"] ,"phoneNumber" : UserDetails!["phoneNumber"], "age" : UserDetails!["age"]
                        ];
                        array.append(user as! [String : String])
                        UserDefaults.standard.set(array, forKey:"currentUser")
                    }
                    print("insertion in user.Default with succes")
                    //*****End***//

                    /*
                    for (key, value) in UserDetails! {
                        print("\(key)  ---> \(value)")
                    }*/
                }







            }
        })
    }
}
