import UIKit
import  FirebaseDatabase
class CircuitListVCTest: UIViewController , UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var listAdverts: UITableView!
    @IBOutlet weak var searchView : UIView!
    @IBOutlet weak var loadingTableIndicator :UIActivityIndicatorView!
      var currentOffset : CGPoint?
    var databaseHandle : DatabaseHandle?
    var annoces : [Annonce]  = []
    let DB_BASE = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.listAdverts.delegate = self
        self.listAdverts.dataSource = self
        self.listAdverts.isUserInteractionEnabled = true
        self.listAdverts.allowsSelection = true
        //loadingTableIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray

        loadingTableIndicator.startAnimating()
        DataService.instance.getAllAdverts(completion: reloadList)

    }

    func reloadList(annonces : [Annonce]){
        self.annoces = annonces
        listAdverts.reloadData()
        loadingTableIndicator.stopAnimating()
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("le nombre des cellul est : \(annoces.count)")
        return  annoces.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCell", for: indexPath) as! CellTableViewTestTableViewCell
        cell.fromLbl.text = annoces[indexPath.row].fromName
        cell.hourLbl.text = annoces[indexPath.row].hourMinute
        cell.toLbl.text = annoces[indexPath.row].toName
        cell.numberPlacesLbl.text = annoces[indexPath.row].numberOfplaces
        if let price  : String = annoces[indexPath.row].Uprice{
            cell.priceLbl.text = "\(price) dt"
        }
        cell.dateLbl.text = annoces[indexPath.row].date
        cell.userImg.image = annoces [indexPath.row].userPicture?.image
        cell.userImg.roundedImage()
        cell.cellView.roundedViewCell(cornerRadius: (Double(cell.cellView.frame.size.height / 2)))
        cell.priceViewCell.roundedPricePersonViewCell()
        cell.nPlacesViewCell.roundedPricePersonViewCell()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let detail = mainStoryBoard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
                    detail.idUser = annoces[indexPath.row].driverID!
                    detail.idAdvert = annoces[indexPath.row].annonceId!
                    detail.From = annoces[indexPath.row].fromName!
                    detail.To = annoces[indexPath.row].toName!
                    detail.Date = annoces[indexPath.row].date!
                    detail.Hour = annoces[indexPath.row].hourMinute!
                    detail.numberOfPlaces = Int(annoces[indexPath.row].numberOfplaces!)!
                    detail.UPrice = Int(annoces[indexPath.row].Uprice!)!
                    detail.From = annoces[indexPath.row].fromName!
                    detail.annonce = annoces[indexPath.row]
            self.present(detail, animated: true, completion: nil)
    }


    @IBAction func onMenuIconPressed(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let listAdvertsVC = mainStoryBoard.instantiateViewController(withIdentifier: "CircuitListVCTest") as! CircuitListVCTest
        self.searchView.isHidden = true
        self.navigationController?.pushViewController(listAdvertsVC, animated: true)
    }

    @IBAction func onProfilIconPressed(_ sender: Any) {
    }

    override func viewWillAppear(_ animated: Bool) {
        DataService.instance.getAllAdverts(completion: reloadList)
    }










    @IBAction func onSearchIconPressed(_ sender: Any) {
        if self.searchView.isHidden {
            self.moveTableViewDown()
        }else{
            self.moveTableViewToOriginalPosition()
        }
        self.searchView.isHidden = !self.searchView.isHidden
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if (touch.view != self.searchView && !self.searchView.isHidden) {
                self.moveTableViewDown()
                self.searchView.isHidden = !self.searchView.isHidden
            }
        }
    }

    func moveTableViewDown() {
        DispatchQueue.main.async {
            self.currentOffset = self.listAdverts.contentOffset // saving current position of tableView
            let maxY = self.listAdverts.contentOffset.y
            let offset = CGPoint.init(x: 0, y: maxY-self.searchView.frame.height) // set moving up value
            self.listAdverts.setContentOffset(offset, animated: false)
        }
    }

    func moveTableViewToOriginalPosition() {
        DispatchQueue.main.async {
            self.listAdverts.contentOffset =  self.currentOffset!
        }
    }



}

