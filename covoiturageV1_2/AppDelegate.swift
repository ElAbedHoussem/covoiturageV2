//
//  AppDelegate.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/2/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import  FirebaseAuth
import FBSDKCoreKit
import  GooglePlaces
import  GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyDz8iyBNbDByJ5phu0-XkMx_tt5DEr_2CM")
        GMSPlacesClient.provideAPIKey("AIzaSyDz8iyBNbDByJ5phu0-XkMx_tt5DEr_2CM")
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if Auth.auth().currentUser == nil {
            let authVC = storyboard.instantiateViewController(withIdentifier: "AuthVC") as! AuthVC
            window?.makeKeyAndVisible()
            window?.rootViewController?.present(authVC, animated: true, completion: nil)
        }
        else{
            AuthService.instance.saveUserInSessionManager(Mail:  (Auth.auth().currentUser?.email)!)
            let ListCircuitVC = storyboard.instantiateViewController(withIdentifier: "CircuitListVCTest") as! CircuitListVCTest
            window?.makeKeyAndVisible()
            window?.rootViewController?.present(ListCircuitVC, animated: true, completion: nil)
        }
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
         }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

        self.saveContext()
    }


    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "covoiturageV1_2")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()


    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
               
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

