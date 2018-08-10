//
//  File.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/7/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import Foundation
import FirebaseDatabase
import  FirebaseStorage
//get the database reference from FirebaseDatabase
let DB_BASE = Database.database().reference()
///get the storage reference from FirebaseStorage
let DB_STORAGE = Storage.storage().reference()
class DataService {
    // create references for evry single child in Firebase
    static let instance  = DataService()
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
     private var _REF_CARS = DB_BASE.child("cars")
     private var _REF_MESSAGES = DB_BASE.child("messages")
     private var _REF_ADVERTS = DB_BASE.child("adverts")
      private var _REF_STREETS = DB_BASE.child("street")
     private var _REF_CITIES = DB_BASE.child("cities")
     private var _REF_GOVERNORATES = DB_BASE.child("governorates")
    private var _REF_PICTURE = DB_STORAGE.child("images")

    
    
    var REF_BASE : DatabaseReference {
        return _REF_BASE
    }
    var REF_USERS : DatabaseReference {
        return _REF_USERS
    }
    var REF_CARS : DatabaseReference {
        return _REF_CARS
    }
    var REF_MESSAGES: DatabaseReference {
        return _REF_MESSAGES
    }
    

    //create a Firebase user in firebase/Auth
    func createDBUser(uid: String, userData: Dictionary <String,Any>){
        REF_USERS.child(uid).setValue(userData)
    }
    // create an object user and storage him in Firebase/Database
    func createUser(email: String , password: String,firstName :String, lastName : String , phoneNumber : Double, age : Int, picture : Data){
        //generate a random userkey to index the user
        let userID = REF_USERS.childByAutoId().key
        print(_REF_PICTURE.putData(picture))
        //create a table with the data from the method
        let userData = ["userID": userID , "email" : email , "password" : password,"firstName" : firstName , "lastName" : lastName ,"phoneNumber" : phoneNumber,"age" : age] as [String : Any]
        // save the userData information in the child "users"
        REF_USERS.child(userID).setValue(userData)
    }
    
}
