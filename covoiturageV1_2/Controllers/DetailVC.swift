//
//  DetailVC.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/17/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    @IBOutlet weak var ps: UILabel!
    @IBOutlet weak var Uprice: UILabel!
    @IBOutlet weak var nbrPlaces: UILabel!
    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var to: UILabel!
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var mail: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    var toDataUserPicture : Data?

    var PS : String = ""
    var Hour : String = ""
    var Date : String = ""
    var To : String = ""
    var From : String = ""
    var FullName : String = ""
    var Age : Int = 0
    var UPrice : Int = 0
    var Mail : String = ""
    var Number : Int = 0
    var numberOfPlaces : Int = 0
    var image : UIImage = UIImage()
    var user : [String : Any] = [String : Any]()
    var annonce : Annonce = Annonce()

    override func viewDidLoad() {
        super.viewDidLoad()
        extractData()
        fillTheBlancs()
    }

    @IBAction func onReserveWasPressed(_ sender: UIButton) {
    }
    
    @IBAction func onCommunicateWasPressed(_ sender: Any) {
    }

    func extractData(){
        self.From = annonce.fromName!
        self.To = annonce.toName!
        self.Date = annonce.date!
        self.PS = annonce.ps!
        self.UPrice  = Int(annonce.Uprice!)!
        self.numberOfPlaces = Int(annonce.numberOfplaces!)!
        self.Hour = annonce.hourMinute!
        if let firstname : String = annonce.driverInfo!["firstName"] as! String {
            if let lastName : String = annonce.driverInfo!["lastName"] as! String{
                self.FullName = "\(firstname) \(lastName)"
            }
        }
        if let age : String = annonce.driverInfo!["age"]  as? String{
            self.Age = Int(age)!
        }
        self.Mail = annonce.driverInfo!["email"] as! String
        if let tel : String = annonce.driverInfo!["phoneNumber"]  as? String{
            self.Number = Int(tel)!
        }
    }

    func fillTheBlancs(){
        self.from.text = From
        self.to.text = To
        self.date.text = Date
        self.ps.text = PS
        self.Uprice.text = String(UPrice)
        self.nbrPlaces.text = String(numberOfPlaces)
        self.hour.text = Hour





    }
}
