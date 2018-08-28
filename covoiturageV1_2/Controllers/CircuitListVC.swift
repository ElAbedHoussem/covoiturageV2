import UIKit
import  FirebaseDatabase
class CircuitListVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var listAdverts: UITableView!
    var databaseHandle : DatabaseHandle?
    var annoces : [Annonce]  = []
    let DB_BASE = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.listAdverts.delegate = self
        self.listAdverts.dataSource = self
//        listAdverts.rowHeight = UITableViewAutomaticDimension
//        listAdverts.estimatedRowHeight = 253
        DataService.instance.getAllAdverts(completion: reloadList)
    }
    func reloadList(annonces : [Annonce]){
        self.annoces = annonces
        listAdverts.reloadData()
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 253
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("le nombre des cellul est : \(annoces.count)")
        return  annoces.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "CellTableView", for: indexPath) as! CellTableView
            cell.fromLbl.text = annoces[indexPath.row].fromName
            cell.hourLbl.text = annoces[indexPath.row].hourMinute
            cell.toLbl.text = annoces[indexPath.row].toName
            cell.numberPlacesLbl.text = annoces[indexPath.row].numberOfplaces
        if let nbrp : Int = Int(annoces[indexPath.row].numberOfplaces!) as? Int{
                if nbrp > 2 {
                    cell.numberPlacesLbl.textColor = UIColor.green
                }
                else{
                    if  nbrp > 0 && nbrp <= 2 {
                        cell.numberPlacesLbl.textColor  = UIColor.red
                    }else{
                        cell.numberPlacesLbl.text = " y a plus de place"
                        cell.numberPlacesLbl.textColor  = UIColor.red
                    }
                }
            }
            cell.priceLbl.text = annoces[indexPath.row].Uprice
            cell.dateLbl.text = annoces[indexPath.row].date
            cell.userImg.image = annoces [indexPath.row].userPicture?.image
            cell.userImg.roundedImage()
            cell.cellView.roundedViewCell()
            return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let detail = mainStoryBoard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        detail.From = annoces[indexPath.row].fromName!
                detail.To = annoces[indexPath.row].toName!
                detail.Date = annoces[indexPath.row].date!
                detail.Hour = annoces[indexPath.row].hourMinute!
                detail.numberOfPlaces = Int(annoces[indexPath.row].numberOfplaces!)!
                detail.UPrice = Int(annoces[indexPath.row].Uprice!)!
                detail.From = annoces[indexPath.row].fromName!

                detail.annonce = annoces[indexPath.row]
        print(indexPath.row)
                 //self.navigationController?.pushViewController(detail, animated: true)
        self.present(detail, animated: true, completion: nil)
    }

}

