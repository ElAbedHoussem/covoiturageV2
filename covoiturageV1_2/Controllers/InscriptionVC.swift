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
class InscriptionVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var telNumberTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var image: UIImageView!
    var selectedImageTag = 0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var profilImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // fetchData()
        
        
    }
    

    @IBAction func onEnregistrerBtnPressed(_ sender: UIButton) {
        if ( nameTextField.text != nil && lastNameTextField.text != nil && passwordTextField.text != nil && mailTextField.text != nil && telNumberTextField.text != nil) {
            AuthService.instance.registerUser(withEmail: mailTextField.text!, andPassword: passwordTextField.text!, firstName: nameTextField.text!, lastName: lastNameTextField.text!, age: Int(ageTextField.text!)!, phoneNumber: Double(telNumberTextField.text!)!, picture: image, userCreationComplete: { (succes, registrationError) in
                if succes{
                   
                    /*
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let authVC = mainStoryboard.instantiateViewController(withIdentifier: "AuthVC") as! AuthVC
                    self.navigationController?.pushViewController(authVC, animated: true)
                    */
                }
                else{
                    print(String(describing: registrationError?.localizedDescription))
                }
            })
        }
    }
    
    
    
    
    
    
    @IBAction func takePhoto(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilImage.contentMode = .scaleToFill
            profilImage.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
}

