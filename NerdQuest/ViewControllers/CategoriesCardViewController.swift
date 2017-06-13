//
//  CategoriesCardViewController.swift
//  NerdQuest
//
//  Created by Luiz Fernando Aquino Dias on 24/05/17.
//  Copyright © 2017 Town Tree. All rights reserved.
//

import UIKit
import Presentation
import Hue
import SwiftyJSON

class CategoriesCardViewController: PresentationController, CategoriesCellDelegate, APIProtocol {

    private let customNQDarkBlue = UIColor(red: 24.0/255.0, green: 10.0/255.0, blue: 53.0/255.0, alpha: 1)
    private let customNQBlue = UIColor(red: 42.0/255.0, green: 18.0/255.0, blue: 101.0/255.0, alpha: 1)
    private let customNQPink = UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 119.0/255.0, alpha: 1)
    private let customNQDarkBlueWithAlpha = UIColor(red: 24.0/255.0, green: 10.0/255.0, blue: 53.0/255.0, alpha: 0.5)
    private let customNQBlueWithAlpha = UIColor(red: 42.0/255.0, green: 18.0/255.0, blue: 101.0/255.0, alpha: 0.5)
    private let customNQPinkWithAlpha = UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 119.0/255.0, alpha: 0.5)
    private let fineAdjustment:CGFloat = 0.033
    private var categoryList = [Category]()
    private var myAPI = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationTitle = false
//        self.navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == true, animated: true)
        self.navigationItem.setHidesBackButton(true, animated: true)
        addGradient(from: customNQBlue, to: customNQPink)
        self.showHUD()
        myAPI.getLocalFrom(filename: "Categories", delegate: self)
    }

    func addGradient(from: UIColor, to: UIColor){
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = self.view.frame.size
        gradient.colors = [from.cgColor, to.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        print("passou metodo")
        UIView.animate(withDuration: 1.0, animations: {
            self.view.layer.backgroundColor = UIColor.clear.cgColor
//            self.addGradient(from: self.customNQBlue, to: UIColor.black)
            self.view.layer.insertSublayer(gradient, at: 0)
            print("passou animacao")
        })
    }
    
    struct Constants {
        static let startSetSegue = "StartQuestions"
    }
    
    struct BackgroundImage {
        let name: String
        let left: CGFloat
        let top: CGFloat
        let speed: CGFloat
        
        init(name: String, left: CGFloat, top: CGFloat, speed: CGFloat) {
            self.name = name
            self.left = left
            self.top = top
            self.speed = speed
        }
        
        func positionAt(_ index: Int) -> Position? {
            var position: Position?
            
            if index == 0 || speed != 0.0 {
                let currentLeft = left + CGFloat(index) * speed
                position = Position(left: currentLeft, top: top)
            }
            
            return position
        }
    }
    
    struct  ForegroundContent {
        let name: String
        let left: CGFloat
        let top: CGFloat
        let speed: CGFloat
        
        init(name: String, left: CGFloat, top: CGFloat, speed: CGFloat) {
            self.name = name
            self.left = left
            self.top = top
            self.speed = speed
        }
        
        func positionAt(_ index: Int) -> Position? {
            var position: Position?
            
            if index == 0 || speed != 0.0 {
                let currentLeft = left + CGFloat(index) * speed
                position = Position(left: currentLeft, top: top)
            }
            
            return position
        }
    }
    
    struct  ForegroundCategory {
        let category: Category
        let left: CGFloat
        let top: CGFloat
        let speed: CGFloat
        
        init(category: Category, left: CGFloat, top: CGFloat, speed: CGFloat) {
            self.category = category
            self.left = left
            self.top = top
            self.speed = speed
        }
        
        func positionAt(_ index: Int) -> Position? {
            var position: Position?
            
            if index == 0 || speed != 0.0 {
                let currentLeft = left + CGFloat(index) * speed
                position = Position(left: currentLeft, top: top)
            }
            
            return position
        }
    }
    
    lazy var leftButton: UIBarButtonItem = { [unowned self] in
        let leftButton = UIBarButtonItem(
            title: "Previous",
            style: .plain,
            target: self,
            action: #selector(moveBack))
        
        leftButton.setTitleTextAttributes(
            [NSForegroundColorAttributeName : UIColor.black],
            for: .normal)
        
        return leftButton
        }()
    
    lazy var rightButton: UIBarButtonItem = { [unowned self] in
        let rightButton = UIBarButtonItem(
            title: "Next",
            style: .plain,
            target: self,
            action: #selector(moveForward))
        
        rightButton.setTitleTextAttributes(
            [NSForegroundColorAttributeName : UIColor.black],
            for: .normal)
        
        return rightButton
        }()
    
    // MARK: - Configuration
    
    func configureSlides() {
        let ratio: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 1 : 0.6
        let font = UIFont(name: "HelveticaNeue", size: 34.0 * ratio)!
        let color = UIColor(hex: "FFE8A9")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        let attributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: color,
                          NSParagraphStyleAttributeName: paragraphStyle]
        
//        let contents = [Content]()
//        for catItem in categoryList{
//            let title = catItem.title
//            let id  = catItem.id
//            let tag = catItem.tag
//            let image = catItem.image
//            let isActive = catItem.isActive
//            let available = catItem.available
//            let hashDaCategoria = catItem.hashDaCategoria
//            let version = catItem.version
//            let price = catItem.price
//            let numberOfMembers = catItem.numberOfMembers
//            let numberOfPosts = catItem.numberOfPosts
//            let details = catItem.details
//            contents.append(<#T##newElement: Content##Content#>)
//        }
        let contents = categoryList.map { content -> Content in
            let cell = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! CategoriesCollectionViewCell
            cell.categoryTitleLabel.text = content.title
            cell.cellDelegate = self
            let position = Position(left: 0.7, top: 0.5 + fineAdjustment)
            
            return Content(view: cell /*label*/, position: position)
        }
        
        var slides = [SlideController]()
        
        for index in 0...contents.count-1 {
            let controller = SlideController(contents: [contents[index]])
            controller.add(animations: [Content.centerTransition(forSlideContent: contents[index])])
            
            slides.append(controller)
        }
        
        add(slides)
    }
    
    func configureBackground() {
        var contents = [Content]()
        let groundView = UIView(frame: CGRect(x: 0, y: 0, width: 1024, height: 60))
        groundView.backgroundColor = UIColor.black //UIColor(hex: "FFCD41")
        let groundContent = Content(view: groundView,
                                    position: Position(left: 0.0, bottom: 0.068), centered: false)
        contents.append(groundContent)
        
        addToBackground([groundContent])
    }
    
    func configureForeground() {

        var foregroundCategories=[ForegroundCategory]()
        var foregroundButtons=[ForegroundContent]()
        
        var leftValue = 0.0
        for categoryItem in categoryList {
            let fgCat = ForegroundCategory(category: categoryItem, left: CGFloat(leftValue), top: 0.2 + fineAdjustment, speed: -1.0)
            var buttonLabel = ""
            
            if categoryItem.price=="free"{
                buttonLabel="Jogar"
            }else{
                buttonLabel="Comprar"
            }
            
            let fgButton = ForegroundContent(name: buttonLabel, left: CGFloat(leftValue+0.225), top: 0.7 + fineAdjustment, speed: -1.0)
            leftValue = leftValue + 1.0
            foregroundCategories.append(fgCat)
            foregroundButtons.append(fgButton)
        }
        
        var contents = [Content]()
        
        for foregroundCategoryItem in foregroundCategories {
            let imageView = UIImageView(image: UIImage(data: foregroundCategoryItem.category.image as Data, scale: 2.0))
            if let position = foregroundCategoryItem.positionAt(0) {
                contents.append(Content(view: imageView, position: position, centered: false))
            }
        }

        var buttonContents = [Content]()
        
        for foregroundButton in foregroundButtons {
            let buyOrPlayButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200.0, height: 50.0))
            buyOrPlayButton.layer.cornerRadius = 26
            buyOrPlayButton.layer.borderWidth = 2
            buyOrPlayButton.addTarget(self, action: #selector(buySetOfQuestions), for: .touchUpInside)
            buyOrPlayButton.addTarget(self, action: #selector(highlightBorder), for: .touchDown)
            // TODO: Customize the button border color according to the image predominant dark color
            buyOrPlayButton.layer.borderColor = customNQBlue.cgColor
            buyOrPlayButton.titleLabel!.font = UIFont(name: "Montserrat-Bold", size: 15.0)
            buyOrPlayButton.setTitleColor(customNQBlue, for: .normal)
            buyOrPlayButton.setTitle(foregroundButton.name, for: .normal)
            buyOrPlayButton.setTitleColor(customNQBlueWithAlpha, for: .highlighted)
            
            
            if let position = foregroundButton.positionAt(0) {
                buttonContents.append(Content(view: buyOrPlayButton, position: position, centered: false))
            }
        }

        for row in 1...categoryList.count {
            for (column, foregroundCategory) in foregroundCategories.enumerated() {
                if let position = foregroundCategory.positionAt(row), let content = contents.at(column) {
                    addAnimation(TransitionAnimation(content: content, destination: position,
                                                     duration: 2.0, damping: 1.0), forPage: row)
                    self.addGradient(from: self.customNQBlue, to: UIColor.black)
                    print("passou tentativa!")
                }
            }
        }

        for row in 1...categoryList.count {
            for (column, foregroundButton) in foregroundButtons.enumerated() {
                if let position = foregroundButton.positionAt(row), let content = buttonContents.at(column) {
                    addAnimation(TransitionAnimation(content: content, destination: position,
                                                     duration: 2.0, damping: 1.0), forPage: row)
                }
            }
        }
        addToForeground(contents)
        addToForeground(buttonContents)
    }
    
    func buySetOfQuestions(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        if btnsendtag.tag == 0 {
            // Un-Highlight Button Border
            sender.layer.borderColor = customNQBlue.cgColor
            self.callSegueFromCell(myData: "luiz" as AnyObject)
        }
    }

    func highlightBorder(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        if btnsendtag.tag == 0 {
            sender.layer.borderColor = customNQBlueWithAlpha.cgColor
        }
    }
    
    func callSegueFromCell(myData dataobject: AnyObject) {
        let myStoryboard = UIStoryboard(name : "Main" , bundle: nil)
        let loadingViewController = myStoryboard.instantiateViewController(withIdentifier: "LoadingVC") as! LoadingContentViewController

        self.navigationController?.pushViewController(loadingViewController, animated: true)
    }

    func didReceiveResult(results: JSON) {
        var categories = [Category]()
        for (_,subJson):(String, JSON) in results {
            let category = Category()
            category.id        = subJson["id"].stringValue
            category.tag      = subJson["tag"].stringValue
            category.isActive  = subJson["isActive"].boolValue
            category.available = subJson["available"].boolValue
            category.version   = subJson["version"].stringValue
            category.price     = subJson["price"].stringValue
            category.title     = subJson["title"].stringValue
            category.details   = subJson["details"].stringValue
            category.numberOfMembers = subJson["numberOfMembers"].intValue
            category.numberOfPosts   = subJson["numberOfPosts"].intValue
            category.hashDaCategoria = subJson["hashDaCategoria"].stringValue
            categories.append(category)
            if let img = UIImage(named: subJson["image"].stringValue) {
                let data = UIImagePNGRepresentation(img) as NSData?
                category.image = data!
            }
        }
        categoryList = categories
        self.hideHUD()
        configureSlides()
        configureBackground()
        configureForeground()
    }
    
    func didErrorHappened(error: NSError) {
        self.hideHUD()
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
        if let message = error.userInfo["message"]{
            print("\((message as AnyObject).description)")
            alert.title = "Oops! 😮"
            alert.message = message as? String
            //Cleaning our questions and answers dic.
            categoryList = []
        }else {
            alert.title = "Erro"
            alert.message = "Não foi possível ao ler as categorias. Tente novamente mais tarde (1011)."
        }
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

protocol CategoriesCellDelegate {
    func callSegueFromCell(myData dataobject: AnyObject)
}

extension Array {
    
    func at(_ index: Int?) -> Element? {
        var object: Element?
        if let index = index , index >= 0 && index < endIndex {
            object = self[index]
        }
        
        return object
    }
}
