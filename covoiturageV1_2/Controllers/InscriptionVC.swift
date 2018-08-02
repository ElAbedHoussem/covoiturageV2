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
class InscriptionVC: UIViewController {

    var selectedImageTag = 0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var profilImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestures()
        fetchData()
    }
    
    func addTapGestures() {
        let tapGR2 = UITapGestureRecognizer(target: self, action: #selector(tappedImage))
        profilImage.addGestureRecognizer(tapGR2)
        profilImage.tag = 3
    }
    
    @IBAction func clearImagesCache(_ sender: Any) {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentPath = documentsURL.path
        
        do {
            let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
            for file in files {
                try fileManager.removeItem(atPath: "\(documentPath)/\(file)")
            }
        } catch {
            print("could not clear cache")
        }
    }
    
    
}



extension InscriptionVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func tappedImage(_ sender: UITapGestureRecognizer) {
        // Make sure device has a camera
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // Save tag of image view we selected
            if let view = sender.view {
                selectedImageTag = view.tag
            }
            
            // Setup and present default Camera View Controller
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Dismiss the view controller a
        picker.dismiss(animated: true, completion: nil)
        
        // Get the picture we took
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set the picture to be the image of the selected UIImageView
        profilImage.image = image
        
        
        // Save imageData to filePath
        
        // Get access to shared instance of the file manager
        let fileManager = FileManager.default
        
        // Get the URL for the users home directory
        let documentsURL =  fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // Get the document URL as a string
        let documentPath = documentsURL.path
        
        // Create filePath URL by appending final path component (name of image)
        let filePath = documentsURL.appendingPathComponent("\(String(selectedImageTag)).png")
        
        
        // Check for existing image data
        do {
            // Look through array of files in documentDirectory
            let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
            
            for file in files {
                // If we find existing image filePath delete it to make way for new imageData
                if "\(documentPath)/\(file)" == filePath.path {
                    try fileManager.removeItem(atPath: filePath.path)
                }
            }
        } catch {
            print("Could not add image from document directory: \(error)")
        }
        
        
        // Create imageData and write to filePath
        do {
            if let pngImageData = UIImagePNGRepresentation(image) {
                try pngImageData.write(to: filePath, options: .atomic)
            }
        } catch {
            print("couldn't write image")
        }
        
        // Save filePath and imagePlacement to CoreData
        let container = appDelegate.persistentContainer
        let context = container.viewContext
        let entity = Image(context: context)
        entity.filePath = filePath.path
        appDelegate.saveContext()
        
        
    }
    
    
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
    
    
}
