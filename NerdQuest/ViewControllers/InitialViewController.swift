//
//  InitialViewController.swift
//  DemoExpandingCollection
//
//  Created by Luiz Dias on 6/8/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import RealmSwift
import SwiftyJSON

class InitialViewController: UIViewController, APIProtocol {

    @IBOutlet weak var startButton: UIButton!
    
    var myAPI = API()
    var tableData = [""]
    var questionList: NSMutableArray = []
    var activeQuestionIndex = 0
    var numberOfQuestionsInCategory = 1
    private let realm = try! Realm()
    private var localHash = AllCategories()
    let categoriesHashEndpoint = "/57cb4c4b0f00001217a1da1b"
    let categoriesEndpoint = "/57c3b4bb100000061c875cef"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//      TODO: Remove the conventional loading HUD and use a loading animation inside the green button, instead.
        self.showHUD()
        
        // Categories with hash at the beggining of the JSON:  "/57cb4af30f0000d816a1da1a"
        // First we must check the categories hash.
        let allCategoriesHash = realm.objects(AllCategories.self)
        
        for result in allCategoriesHash {
            localHash = result
        }
        
//        if localHash == nil {
//            request(endpoint: categoriesEndpoint)
//        } else {
//            request(endpoint: categoriesHashEndpoint)
//        }

        startButton.setTitle(NSLocalizedString("START", comment: "the begining. Change to Login in the future."), for: .normal)
        startButton.backgroundColor = UIColor.init(red: 255.0/255, green: 0.0/255, blue: 121.0/255, alpha: 1.0)
        startButton.layer.cornerRadius = 26
        startButton.layer.borderWidth = 0
        startButton.layer.borderColor = UIColor.black.cgColor
        
        // Finds the current position and simply add more space to place the next button
        var position = startButton.frame.origin
        position.y = position.y + 100
        position.x = self.view.center.x

        // Add a custom login button to your app
        let fbLoginButton = UIButton()
        fbLoginButton.backgroundColor = UIColor.init(red: 59.0/255, green: 89.0/255, blue: 152.0/255, alpha: 1.0)
        fbLoginButton.layer.cornerRadius = 26
        fbLoginButton.frame = startButton.frame
        fbLoginButton.center = position
        fbLoginButton.setTitle("Entrar com Facebook", for: UIControlState.normal)
        fbLoginButton.titleLabel!.font = UIFont(name: "Montserrat-Bold", size: 15.0)
        fbLoginButton.setImage(UIImage(named: "facebookF.png"), for: UIControlState.normal)
        
        // Handle clicks on the button
        fbLoginButton.addTarget(self, action: #selector(InitialViewController.loginButtonClicked), for: UIControlEvents.touchUpInside)
        
        // Add the button to the view
        //self.view.addSubview(fbLoginButton)
        
        // Do any additional setup after loading the view.
    }

    // Once the button is clicked, show the login dialog
    func loginButtonClicked(){
        let login = FBSDKLoginManager()
        login.logIn(withReadPermissions: ["public_profile"], from: self) { (result, error) in
            if (error != nil){
                print("Erro ao realizar o login do Facebook")
            }else if (result?.isCancelled)! {
                print("Cancelou o login Facebook")
            }else {
                print("LOGOU no Facebook")
            }}
    }
    
    func request(endpoint: String){
        myAPI.get(path: endpoint, delegate: self)
    }
    
    func  didReceiveResult(results result: JSON) {
        let categoriesRetrieved = realm.objects(Category.self)
        
        //Clearing the realm before writing new objects
        try! realm.write {
            realm.delete(categoriesRetrieved)
        }
        
        let categories: NSMutableArray = []
        
        NSLog("Categories.didReceiveResult: \(result)")
        
        for (_,subJson):(String, JSON) in result {
            let category = Category()
            category.id = subJson["id"].stringValue
            category.name = subJson["name"].stringValue
            category.available = subJson["available"].boolValue
            category.hashDaCategoria = subJson["hashDaCategoria"].stringValue
// TODO: Retrieve image from URL and save locally
//            category.image = subJson["image"].stringValue
            category.isActive = subJson["isActive"].boolValue
            category.price = subJson["price"].stringValue
            print("URL da imagem: \(category.image)")
            categories.add(category)
            
            try! realm.write {
                realm.add(category)
            }
        }
        self.hideHUD()
    }
    
    func didErrorHappened(error: NSError) {
        self.hideHUD()
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
        if let message = error.userInfo["message"]{
            print("\((message as AnyObject).description)")
            alert.title = "Oops! 😮"
            alert.message = message as? String
            questionList = []
//            self.tableView.reloadData()
        }else {
            alert.title = "Erro"
//            alert.message = "Há um problema na conexão. Tente novamente mais tarde (1011)."
            alert.message = "Você precisa de uma conexão com a internet para ver o conteúdo. Conecte-se e tente novamente!"
        }
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
