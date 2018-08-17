//
//  Annonce.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/15/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import Foundation

class Annonce{

    var fromName : String?
    var fromLatitude : Double?
    var fromLongitude : Double?
    var toName : String?
    var toLatitude : Double?
    var toLongitude : Double?

    var date : String?
    var hourMinute : String?

    var mark : String?
    var model : String?
    var numberOfplaces : String?
    var Uprice : String?

    var ps : String?

    var driverInfo : [String : Any]?



    init(fromName :String!, fromLatitude : Double ,fromLongitude : Double, toName : String, toLatitude : Double , toLongitude : Double, date : String, hourMinute : String , mark : String , model : String , numberOfplaces : String , Uprice : String , ps : String) {
        self.fromName = fromName
        self.fromLatitude = fromLatitude
        self.fromLongitude = fromLongitude

        self.toName = toName
        self.toLatitude = toLatitude
        self.toLongitude = toLongitude

        self.date = date
        self.hourMinute = hourMinute

        self.mark = mark
        self.model = model
        self.numberOfplaces = numberOfplaces
        self.Uprice = Uprice

        self.ps = ps

        self.driverInfo = AuthService.instance.getUserFromSessionManager()
    }

    func getInfoAnnonce() ->[String : Any] {
        return (["fromName" : self.fromName ,"fromLatitude" : self.fromLatitude , "fromLongitude" : self.fromLongitude,
                 "toName" : self.toName ,"toLatitude" : self.toLatitude , "toLongitude" : self.toLongitude , "date" : self.date ,
                 "hourMinute" : self.hourMinute , "mark" : self.mark , "model" : self.model , "numberOfplaces" : self.numberOfplaces ,
                 "Uprice" : self.Uprice , "ps" : self.ps ,  "userInformation" : driverInfo
            ] as? [String : Any])!
    }

    func addAnoonce(){
        DataService.instance.createAdvert(AdvertInfos: self.getInfoAnnonce())
    }






}
