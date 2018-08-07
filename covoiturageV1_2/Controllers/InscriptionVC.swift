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
class InscriptionVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    var selectedImageTag = 0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var profilImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // fetchData()
        
        
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



/*extension InscriptionVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   
    
    
    
    
    func fetchData() {
        // Set up fetch request
        let container = appDelegate.persistentContainer
        let context = container.viewContext
        let fetchRequest = NSFetchRequest <NSManagedObject>(entityName: "User")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            // Retrive array of all image entities in core data
            let users = try?  context.fetch(fetchRequest)
            for user in users! {
                if  var filePath = user.value(forKey: "filePath"){
                    // Retrive image data from filepath and convert it to UIImage
                    if FileManager.default.fileExists(atPath: filePath as! String) {
                        if let contentsOfFilePath = UIImage(contentsOfFile: filePath as! String) {
                            profilImage.image = contentsOfFilePath
                        }
                    }
                }
            }
        }
    }
    
 
}*/
