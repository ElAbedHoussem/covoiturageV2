//
//  AddACircuitVC.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/6/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import UIKit
import  JTAppleCalendar
import CoreLocation
import MapKit
import  GooglePlaces

struct MyPlace {
    var name: String
    var lat: Double
    var long: Double
}
class AddACircuitVC: UIViewController ,UIPickerViewDelegate , UIPickerViewDataSource ,CLLocationManagerDelegate, GMSAutocompleteViewControllerDelegate, UITextFieldDelegate{


    var locationManager = CLLocationManager()
    var chosenPlace: MyPlace?

    var pickerView = UIPickerView()
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var destinationTextFiled: UITextField!
    @IBOutlet weak var departTextField: UITextField!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var hourMinuteTextField: UITextField!



    var matchingItems: [MKMapItem] = [MKMapItem]()
    var tableView = UITableView()
   // @IBOutlet weak var dateLabel: UILabel!
    var aPopupContainer: PopupContainer?
    var testCalendar = Calendar(identifier: .gregorian)
    var currentDate: Date! = Date() {
        didSet {
            setDate()
        }
    }
    var minuteArray : [String] = [String]()
    var hourArray : [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        destinationTextFiled.delegate = self
        departTextField.delegate = self

        pickerView.dataSource = self
        pickerView.delegate = self
        hourMinuteTextField.inputView = pickerView

        minuteArray = PickerService.instance.fillListminute()
        hourArray = PickerService.instance.fillListHour()
        /*
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())

        */
    }















    /////Autocompete using googleservice
    ///*******Begin*************//


    //MARK: textfield
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self

        let filter = GMSAutocompleteFilter()
        autoCompleteController.autocompleteFilter = filter

        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
        return false
    }

    // MARK: GOOGLE AUTO COMPLETE DELEGATE
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let lat = place.coordinate.latitude
        let long = place.coordinate.longitude


        departTextField.text=place.formattedAddress
        chosenPlace = MyPlace(name: place.formattedAddress!, lat: lat, long: long)

        self.dismiss(animated: true, completion: nil) // dismiss after place selected
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ERROR AUTO COMPLETE \(error)")
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: CLLocation Manager Delegate

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while getting location \(error)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
        let location = locations.last
        let lat = (location?.coordinate.latitude)!
        let long = (location?.coordinate.longitude)!


    }

    ///*********End*************///




















    ////Hour and minute UIPickrView Configuration
    //***********Begin**************///
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return hourArray.count
        }
        return minuteArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return hourArray[row]
        }
        return minuteArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var minute = minuteArray[pickerView.selectedRow(inComponent: 1)]
        var hour = hourArray[pickerView.selectedRow(inComponent: 0)]
        if component == 0{
            hour = hourArray[row]
        }else{
            minute = minuteArray[row]
        }
         hourMinuteTextField.text = "\(hour) : \(minute)"

    }
    ////*********End**************///








        //calendar Confiruration
    ////*******Begin**********/
    @IBAction func showCalendar(_ sender: UIButton) {
        let xibView = Bundle.main.loadNibNamed("CalendarPopUp", owner: nil, options: nil)?[0] as! CalendarPopUp
        xibView.calendarDelegate = self
        xibView.selected = currentDate
        xibView.startDate = Calendar.current.date(byAdding: .month, value: -12, to: currentDate)!
        PopupContainer.generatePopupWithView(xibView).show()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

    func setDate() {
        let month = testCalendar.dateComponents([.month], from: currentDate).month!
        let weekday = testCalendar.component(.weekday, from: currentDate)
        let monthName = DateFormatter().monthSymbols[(month-1) % 12] //GetHumanDate(month: month)//
        let week = DateFormatter().shortWeekdaySymbols[weekday-1]

        let day = testCalendar.component(.day, from: currentDate)

        //dateLabel.text = "\(week), " + monthName + " " + String(day)
    }




}













extension AddACircuitVC: CalendarPopUpDelegate {
    func dateChaged(date: Date) {
        currentDate = date
    }
}

/////********End*********///////
















extension AddACircuitVC  {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == departTextField {
            tableView.frame = CGRect(x: 45, y: 81, width: view.frame.width - 50, height: view.frame.height-300)
            tableView.layer.cornerRadius = 5.0
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "locationCell")
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.tag = 18
            
            tableView.rowHeight = 60
            view.addSubview(tableView)
            animateTableView(shouldShow: true , isBegin :true)
        }
        else if textField == destinationTextFiled{
            tableView.frame = CGRect(x: 85, y: 121, width: view.frame.width - 32, height: view.frame.height - 100)
            tableView.layer.cornerRadius = 5.0
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "locationCell")
            tableView.delegate = self
            tableView.dataSource = self

            tableView.tag = 18

            tableView.rowHeight = 60
            view.addSubview(tableView)
            animateTableView(shouldShow: true, isBegin:  false)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == departTextField{
            performSearch(isBegin : true)
            view.endEditing(true)
        } else if textField == destinationTextFiled{
            performSearch(isBegin: false)
            view.endEditing(true)
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == departTextField{
            if departTextField.text == "" {
                UIView.animate(withDuration: 0.2, animations: {
                    print("ecrire une chose dans la zone de depart")
                })
            }
        }
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    
    func animateTableView(shouldShow : Bool ,  isBegin : Bool)
    {
        if shouldShow{
            if isBegin{
                UIView.animate(withDuration: 0.2, animations: {
                    self.tableView.frame = CGRect(x: 15, y: 111, width: self.view.frame.width - 32, height: self.view.frame.height - 100)
                })
            }else{
                UIView.animate(withDuration: 0.2, animations: {
                    self.tableView.frame = CGRect(x: 15, y: 151, width: self.view.frame.width - 32, height: self.view.frame.height - 100)
                })
            }
        }else {
            UIView.animate(withDuration: 0.2, animations: {
                self.tableView.frame = CGRect(x: 20, y: self.view.frame.height, width: self.view.frame.width - 40, height: self.view.frame.height - 170)
            }, completion: { (finished) in
                for subview in self.view.subviews {
                    if subview.tag == 18 {
                        subview.removeFromSuperview()
                    }
                }
            })
        }
    }
}



















extension AddACircuitVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "locationCell")
        let mapItem = matchingItems[indexPath.row]
        print("le mapname est : \(mapItem.name)")
        cell.textLabel?.text = mapItem.name
        cell.detailTextLabel?.text = mapItem.placemark.title
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                if tableView == departTextField
                {
                    print("Begin selected")
                    departTextField.text = tableView.cellForRow(at: indexPath)?.textLabel?.text
                }else if tableView == destinationTextFiled{
                    print("Destination selected")
                    destinationTextFiled.text = tableView.cellForRow(at: indexPath)?.textLabel?.text
                }
                let selectedMapItem = matchingItems[indexPath.row]
                animateTableView(shouldShow: false , isBegin: true)
        }
   func numberOfSections(in tableView: UITableView) -> Int {
        return matchingItems.count
    }
}



















extension AddACircuitVC: MKMapViewDelegate{

    func performSearch(isBegin :Bool){
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        if isBegin {
            request.naturalLanguageQuery = departTextField.text
            print(departTextField.text)
        }else{
            request.naturalLanguageQuery = destinationTextFiled.text
            print(destinationTextFiled.text)
        }
        request.region = mapView.region
        print("region = \(mapView.region)")
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if error != nil{
                print("il y a une erreuur")
                print(error.debugDescription)
            }else if response!.mapItems.count == 0{
                print("no results")
            }else{
                for mapItem in response!.mapItems{
                    self.matchingItems.append(mapItem as MKMapItem)
                    self.tableView.reloadData()
                }
            }
        }

    }
}











