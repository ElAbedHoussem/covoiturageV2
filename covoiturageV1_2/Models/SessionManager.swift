//
//  File.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/15/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import UIKit
class SessionManager : NSObject{
    static let session = SessionManager()

    var userID : String?
    var firstNsame: String?
    var lastName: String?
    var age : String?
    var phoneNumber : String?
    var email: String?
    var password : String?
    //var picture : Data?

}

