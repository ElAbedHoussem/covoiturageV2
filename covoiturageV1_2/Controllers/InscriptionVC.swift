//
//  InscriptionVC.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/1/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import UIKit
import CoreData
import CoreImage
import FirebaseDatabase
class InscriptionVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIPickerViewDelegate , UIPickerViewDataSource{

    var pickerView = UIPickerView()
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var telNumberTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!

    var yearOfBirthArray : [String] = [String]()
    var selectedImageTag = 0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var profilImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        ageTextField.inputView = pickerView

        yearOfBirthArray = PickerService.instance.fillListAge()
       // fetchData()
        
        
    }



    ////Hour and minute UIPickrView Configuration
    //***********Begin**************///
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return yearOfBirthArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return yearOfBirthArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var year = yearOfBirthArray[pickerView.selectedRow(inComponent: 0)]
        year = yearOfBirthArray[row]
        ageTextField.text = year
        print("year = \(ageTextField.text)")

    }
    ////*********End**************///


    
    //user registration
    @IBAction func onEnregistrerBtnPressed(_ sender: UIButton) {
        
        if ( nameTextField.text != nil && lastNameTextField.text != nil && passwordTextField.text != nil && mailTextField.text != nil && telNumberTextField.text != nil) {
            // send data to registerUser to save it
            AuthService.instance.registerUser(withEmail: mailTextField.text!, andPassword: passwordTextField.text!, firstName: nameTextField.text!, lastName: lastNameTextField.text! , phoneNumber: telNumberTextField.text!,age: (ageTextField?.text)! , picture: profilImage!, userCreationComplete: { (succes, registrationError) in
                if succes{
                    ///if the infromations was saved with succes , then we send the user the Auth View Controller

                   print("save with succes ....")

                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let authVC = mainStoryboard.instantiateViewController(withIdentifier: "AuthVC") as! AuthVC
                    self.navigationController?.pushViewController(authVC, animated: true)
                    
                }
                else{
                    print(String(describing: registrationError?.localizedDescription))
                }
            })
        }
    }
    
    
    
    
    
    // this method take a photo
    @IBAction func takePhoto(_ sender: AnyObject) {
        // take a picture from photLibrary
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }

        //we can take a photo with camera also
        // but this need a real phone to simulate it , that's why we will not ue this method for the moment
        /*
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }*/
        
    }
    
    // this method is from UIImagePickerControllerDelegate 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilImage.contentMode = .scaleToFill
            profilImage.clipsToBounds = true
            profilImage.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
}

