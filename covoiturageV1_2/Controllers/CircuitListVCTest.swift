import UIKit
import  FirebaseDatabase
class CircuitListVCTest: UIViewController , UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var listAdverts: UITableView!
    var databaseHandle : DatabaseHandle?
    var annoces : [Annonce]  = []
    let DB_BASE = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.listAdverts.delegate = self
        self.listAdverts.dataSource = self
        DataService.instance.getAllAdverts(completion: reloadList)
    }

    func reloadList(annonces : [Annonce]){
        self.annoces = annonces
        listAdverts.reloadData()
    }

//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  annoces.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if  let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellTableView{
//            cell.fromLbl.text = annoces[indexPath.row].fromName
//            cell.hourLbl.text = annoces[indexPath.row].hourMinute
//            cell.toLbl.text = annoces[indexPath.row].toName
//            cell.numberPlacesLbl.text = annoces[indexPath.row].numberOfplaces
//            cell.priceLbl.text = annoces[indexPath.row].Uprice
//            cell.dateLbl.text = annoces[indexPath.row].date
            cell.userImg.image = annoces [indexPath.row].userPicture?.image
            cell.userImg.roundedImage()
            return cell
        }else{
            return CellTableView()
        }
    }



}


