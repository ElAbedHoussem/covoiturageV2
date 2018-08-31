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
    @IBOutlet weak var infoDriverView : UIView!
    @IBOutlet weak var advertInfoView : UIView!
    @IBOutlet weak var chatBtn : UIButton!
    @IBOutlet weak var  reserve : UIButton!
    var toDataUserPicture : Data?

    var idUser : String = ""
    var idAdvert : String = ""
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
        self.infoDriverView.roundedAdvertDetailsView()
        self.advertInfoView.roundedAdvertDetailsView()
        self.chatBtn.roundedButton()
        self.reserve.roundedButton()
        extractData()
        fillTheBlancs()
        if UPrice == 0 {
            chatBtn.isEnabled = false
            chatBtn.alpha = 0.3
            reserve.isEnabled = false
            reserve.alpha = 0.3
            self.nbrPlaces.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }

    @IBAction func onReturnWasPressed(_ sender: UIButton) {
       self.dismiss(animated: true)
    }

    @IBAction func onReserveWasPressed(_ sender: UIButton) {
        DataService.instance.reserve(advertKey: idAdvert, newNbrPlaces: (self.numberOfPlaces-1) , idClient: idUser, completion: afterReserve)
    }

    func afterReserve( resUpdate : Bool){
        if resUpdate{
            print("ok")
            let alert = UIAlertController(title: "Succes", message: "succes de reservation, soyer au rendez vous :)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
        }else{
            print("not ok")
            let alert = UIAlertController(title: "Erreur", message: "Erreur de reservation", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func onCommunicateWasPressed(_ sender: Any) {
        print(456)
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
        self.Uprice.text = "\(String(UPrice)) Dinars"
        self.nbrPlaces.text = "\(String(numberOfPlaces)) restantes "
        self.hour.text = Hour
    }
    
}
