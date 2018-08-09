//
//  File.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/7/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import Foundation
import FirebaseDatabase
let DB_BASE = Database.database().reference()
class DataService {
    static let instance  = DataService()
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
     private var _REF_CARS = DB_BASE.child("cars")
     private var _REF_MESSAGES = DB_BASE.child("messages")
     private var _REF_ADVERTS = DB_BASE.child("adverts")
      private var _REF_STREETS = DB_BASE.child("street")
     private var _REF_CITIES = DB_BASE.child("cities")
     private var _REF_GOVERNORATES = DB_BASE.child("governorates")
    
    
    
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
    
    
    func createDBUser(uid: String, userData: Dictionary <String,Any>){
        REF_USERS.child(uid).setValue(userData)
    }
    
}
