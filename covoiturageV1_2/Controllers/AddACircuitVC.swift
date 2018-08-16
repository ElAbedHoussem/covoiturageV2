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
    @IBOutlet weak var destinationTextFiled: UITextField!
    @IBOutlet weak var departTextField: UITextField!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var hourMinuteTextField: UITextField!
    @IBOutlet weak var prixUnitaireTextField: UITextField!

    @IBOutlet weak var marqueTextField: UITextField!
    @IBOutlet weak var modeleTextField: UITextField!
    @IBOutlet weak var nombreDePlaceTextField: UITextField!
    @IBOutlet weak var remarqueTextView: UITextView!


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
    var fullDate : String?
    var FromLatitude : Double?
    var FromLongitude : Double?
    var Tolatitude : Double?
    var toLongitude : Double?

    var isBeginTextField = true
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

        isBeginTextField = textField == departTextField ? true : false
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
        print("longuitude = \(long) , latitude = \(lat)")
        if  isBeginTextField{
            departTextField.text=place.formattedAddress
            FromLongitude = long
            FromLatitude = lat
        }
        else {
            destinationTextFiled.text = place.formattedAddress
            toLongitude = long
            Tolatitude = lat
        }
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
        print("hourMinute = \(hourMinuteTextField.text)")

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
        print("\(week), " + monthName + " " + String(day))
        fullDate = "\(week), " + monthName + " " + String(day)
        //dateLabel.text = "\(week), " + monthName + " " + String(day)
    }

    @IBAction func onDeposerWasPressed(_ sender: Any) {
        if (departTextField.text != "") && (destinationTextFiled.text != "") && (hourMinuteTextField.text != "") && (marqueTextField.text != "") && (modeleTextField.text != "") && (nombreDePlaceTextField.text != "") && (prixUnitaireTextField.text != "" && fullDate != "") {

                let annonce = Annonce(fromName: departTextField.text, fromLatitude: FromLatitude!, fromLongitude: FromLongitude!,
                                  toName: destinationTextFiled.text!, toLatitude: Tolatitude!, toLongitude:toLongitude!,
                                  date: fullDate!, hourMinute: hourMinuteTextField.text!,  mark: marqueTextField.text!, model: modeleTextField.text!,
                                  numberOfplaces: nombreDePlaceTextField.text!, Uprice: prixUnitaireTextField.text!)
                annonce.addAnoonce()
                print ("ajout d'annonce avec succee")
        }else{
                print("les chamsp ne sont pas tous remplis ")
        }
    }
}


extension AddACircuitVC: CalendarPopUpDelegate {
    func dateChaged(date: Date) {
        currentDate = date
    }
}

/////********End*********///////
