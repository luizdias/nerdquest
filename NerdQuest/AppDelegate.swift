//
//  AppDelegate.swift
//  DemoExpandingCollection
//
//  Created by Luiz Dias. on 25/05/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import UIKit
import Firebase
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    lazy var navigationController: UINavigationController = { [unowned self] in
        let controller = UINavigationController(rootViewController: self.initialViewController)
        
        return controller
        }()
    
    
    lazy var myStoryboard : UIStoryboard = {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        return story
    }()
    
//    lazy var initialViewController: CategoriesCardViewController = {
//        return CategoriesCardViewController(pages: [])
//    }()
    
    lazy var initialViewController:InitialViewController = {
        let initial = self.myStoryboard.instantiateViewController(withIdentifier: "Initial") as! InitialViewController
        return initial
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureNavigationTabBar()
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        
//        let myStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let initialViewController : InitialViewController = myStoryboard.instantiateViewController(withIdentifier: "Initial") as! InitialViewController
//        
//        let navigationController: UINavigationController = UINavigationController(rootViewController: initialViewController)
//        
        Fabric.with([Crashlytics.self])
        self.logUser()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
    
    func logUser() {
        // TODO: Use the current user's information
        // You can call any combination of these three methods
        Crashlytics.sharedInstance().setUserEmail("user@fabric.io")
        Crashlytics.sharedInstance().setUserIdentifier("12345")
        Crashlytics.sharedInstance().setUserName("Test User")
    }

}



extension AppDelegate {

    func configureNavigationTabBar() {
        //transparent background
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true

        UINavigationBar.appearance().barStyle = .default
        
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: 2)
        shadow.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)

    //    shadow.shadowOffset = k
        UINavigationBar.appearance().titleTextAttributes = [
          NSForegroundColorAttributeName : UIColor.white,
          NSShadowAttributeName: shadow
        ]
      }
}
