//
//  Annonce.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/15/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import Foundation

class Annonce{

    private (set) var fromName : String?
    private (set) var fromLatitude : Double?
    private (set) var fromLongitude : Double?
    private (set) var toName : String?
    private (set) var toLatitude : Double?
    private (set) var toLongitude : Double?

    private (set) var date : String?
    private (set) var hourMinute : String?

    private (set) var mark : String?
    private (set) var model : String?
    private (set) var numberOfplaces : String?
    private (set) var Uprice : String?
    
    private (set) var driverInfo : [String : Any]?





    init(fromName :String!, fromLatitude : Double ,fromLongitude : Double, toName : String, toLatitude : Double , toLongitude : Double, date : String, hourMinute : String , mark : String , model : String , numberOfplaces : String , Uprice : String) {
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

        self.driverInfo = AuthService.instance.getUserFromSessionManager()
    }



    func getInfoAnnonce() ->[String : Any] {
        return (["fromName" : self.fromName ,"fromLatitude" : self.fromLatitude , "fromLongitude" : self.fromLongitude, "toName" : self.toName ,"toLatitude" : self.toLatitude , "toLongitude" : self.toLongitude , "date" : self.date , "hourMinute" : self.hourMinute , "mark" : self.mark , "model" : self.model , "numberOfplaces" : self.numberOfplaces , "Uprice" : self.Uprice , "userInformation" : driverInfo] as? [String : Any])! 
    }



    func addAnoonce(){
        DataService.instance.createAdvert(AdvertInfos: self.getInfoAnnonce())
    }






}
