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
     var REF_BASE = DB_BASE
     var REF_USERS = DB_BASE.child("users")
      var REF_CARS = DB_BASE.child("cars")
      var REF_MESSAGES = DB_BASE.child("messages")
      var REF_ADVERTS = DB_BASE.child("adverts")
      var REF_STREETS = DB_BASE.child("street")
      var REF_CITIES = DB_BASE.child("cities")
      var REF_GOVERNORATES = DB_BASE.child("governorates")

    func createDBUser(uid: String, userData: Dictionary <String,Any>){
        REF_USERS.child(uid).setValue(userData)
    }

    func createUser(email: String , password: String,firstName :String, lastName : String , phoneNumber : String, age : String, picture : Data){
        let userID = REF_USERS.childByAutoId().key
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        DB_STORAGE.child("images").child(userID).putData(picture, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                print("saving picture with succes")
            }
                //print(DB_STORAGE.child("images/\(userID)").putData(picture))
                var userData = ["userID": userID , "email" : email , "password" : password,"firstName" : firstName , "lastName" : lastName ,"phoneNumber" : phoneNumber,"age" : age] as [String : Any]
                self.REF_USERS.child(userID).setValue(userData)
            }
    }

    func createAdvert(AdvertInfos : [String : Any]){
        let advertID = REF_ADVERTS.childByAutoId().key
        var advertInformations = AdvertInfos
        advertInformations["key"] = advertID
        advertInformations["driver"] = AuthService.instance.getUserFromSessionManager()
        REF_ADVERTS.child(advertID).setValue(advertInformations)
    }


}
