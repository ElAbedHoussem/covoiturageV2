//
//  User.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/9/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import Foundation
class UserInfo{

    var id : String?
    var name: String?
    var lastName: String?
    var age : Int?
    var telNumber : Double?
    var mail: String?
    var Password : String?
    var Picture : String?

    init(id : String , mail : String , Password : String , name : String , lastName : String , age : Int , telNumber : Double
        ,Picture :String) {
        
        self.id = id
        self.name = name
        self.lastName = lastName
        self.age = age
        self.telNumber = telNumber
        self.mail = mail
        self.Password = Password
        self.Picture = Picture
    }

    


}
