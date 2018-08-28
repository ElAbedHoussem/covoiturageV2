

import Foundation
import FirebaseDatabase
import  FirebaseStorage
let DB_BASE = Database.database().reference()
let DB_STORAGE = Storage.storage().reference()
class DataService {
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
                var userData = ["userID": userID , "email" : email , "password" : password,"firstName" : firstName , "lastName" : lastName ,"phoneNumber" : phoneNumber,"age" : age] as [String : Any]
                self.REF_USERS.child(userID).setValue(userData)
            }
    }

    func createAdvert(AdvertInfos : [String : Any]){
        print("dans creatAdvert")
        let advertID = REF_ADVERTS.childByAutoId().key
        var advertInformations = AdvertInfos
        advertInformations["key"] = advertID
        REF_ADVERTS.child(advertID).setValue(advertInformations)
    }

    func getAllAdverts (completion : @escaping ([Annonce])->()){
        var i = 0
         var listAdverts : [Annonce] = [Annonce]()
                REF_ADVERTS.observe(DataEventType.value, with: { (snapshot) in
                    if snapshot.childrenCount > 0 {
                        for advert in snapshot.children.allObjects as! [DataSnapshot] {
                            let advertInfo  = advert.value as? [String : AnyObject]
                            let fromName = advertInfo?["fromName"]
                            let fromLatitude = advertInfo?["fromLatitude"]
                            let fromLongitude  = advertInfo?["fromLongitude"]
                            let  toName = advertInfo?["toName"]
                            let toLatitude = advertInfo?["toLatitude"]
                            let toLongitude = advertInfo?["toLongitude"]
                            let date = advertInfo?["date"]
                            let hourMinute = advertInfo?["hourMinute"]
                            let mark = advertInfo?["mark"]
                            let model = advertInfo?["model"]
                            let numberOfplaces = advertInfo?["numberOfplaces"]
                            let Uprice = advertInfo?["numberOfplaces"]
                            let ps = advertInfo?["ps"]
                            let userInfo = advertInfo?["userInformation"]
                            var userID = ""
                            var userImg = UIImageView()
                            for (key , val ) in (userInfo as? [String : Any])!{
                                if key == "userID"{
                                    if let userID : String = val as! String{
                                        userImg = self.getPicture(pictureURL: userID)
                                    }
                                }
                            }
                            let annonce  = Annonce(fromName: fromName as! String, fromLatitude: fromLatitude as! Double, fromLongitude: fromLongitude as! Double, toName: toName as! String, toLatitude: toLatitude as! Double, toLongitude: toLongitude as! Double, date: date as! String, hourMinute: hourMinute as! String, mark: mark as! String, model: model as! String, numberOfplaces: numberOfplaces as! String, Uprice: Uprice as! String, ps: ps as! String, userInfo : userInfo as! [String : Any])
                            annonce.userPicture  = userImg
                            listAdverts.append(annonce)
                            print("Dans getAllAdverts , nombre des anoonces est : \(listAdverts.count)")
                        completion(listAdverts)
                    }
                }
            })
        }

    func getPicture(pictureURL : String) -> UIImageView{
        var userImg = UIImageView()
                    let pictureRef = DB_STORAGE.child("images").child(pictureURL)
                    pictureRef.downloadURL { (url, error) in
                        if error == nil {
                            if let data :Data = NSData(contentsOf: url!) as! Data{
                                let image = UIImage(data: data)
                                userImg.image = image
                            }
                        }else {
                            print(error)
                        }
            }
        return userImg
    }

}
