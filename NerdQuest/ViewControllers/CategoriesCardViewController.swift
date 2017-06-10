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

class CategoriesCardViewController: PresentationController, CategoriesCellDelegate {

    private let customNQDarkBlue = UIColor(red: 24.0/255.0, green: 10.0/255.0, blue: 53.0/255.0, alpha: 1)
    private let customNQBlue = UIColor(red: 42.0/255.0, green: 18.0/255.0, blue: 101.0/255.0, alpha: 1)
    private let customNQPink = UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 119.0/255.0, alpha: 1)
    private let fineAdjustment:CGFloat = 0.033
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationTitle = false
//        self.navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == true, animated: true)
        self.navigationItem.setHidesBackButton(true, animated: true)
        addGradient(from: customNQBlue, to: customNQPink)
        configureSlides()
        configureBackground()
        configureForeground()
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
        
        let titles = [
            "Videosgames",
            "Medieval & Fantasia",
            "Sci-Fi",
            "Retro Games",
            "Cyberpunk"].map { title -> Content in
                let cell = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! CategoriesCollectionViewCell
                cell.buyOrPlayButton.setTitle("luiz", for: .normal)
                cell.categoryTitleLabel.text = title
                cell.cellDelegate = self
                let position = Position(left: 0.7, top: 0.5 + fineAdjustment)
                
                return Content(view: cell /*label*/, position: position)
        }
        
        var slides = [SlideController]()
        
        for index in 0...4 {
            let controller = SlideController(contents: [titles[index]])
            controller.add(animations: [Content.centerTransition(forSlideContent: titles[index])])
            
            slides.append(controller)
        }
        
        add(slides)
    }
    
    func configureBackground() {
//        let backgroundImages = [
////            BackgroundImage(name: "foreground0", left: 0.0, top: 0.2, speed: -0.3),
////            BackgroundImage(name: "singleStar", left: 0.02, top: 0.77, speed: 0.25),
////            BackgroundImage(name: "image", left: 1.3, top: 0.73, speed: -1.5),
////            BackgroundImage(name: "face1", left: 0.0, top: 0.79, speed: -0.24),
////            BackgroundImage(name: "rightAnswer", left: 0.0, top: 0.627, speed: -0.16),
////            BackgroundImage(name: "singleStar", left: 0.0, top: 0.51, speed: -0.08),
////            BackgroundImage(name: "face1", left: 0.0, top: 0.29, speed: 0.0),
////            BackgroundImage(name: "Clouds", left: -0.415, top: 0.14, speed: 0.18),
////            BackgroundImage(name: "Sun", left: 0.8, top: 0.07, speed: 0.0)
//        ]
//        
        var contents = [Content]()
//
//        for backgroundImage in backgroundImages {
//            let imageView = UIImageView(image: UIImage(named: backgroundImage.name))
//            if let position = backgroundImage.positionAt(0) {
//                contents.append(Content(view: imageView, position: position, centered: false))
//            }
//        }
//        
//        addToBackground(contents)
//        addToForeground(contents)
        
//        for row in 1...4 {
//            for (column, backgroundImage) in backgroundImages.enumerated() {
//                if let position = backgroundImage.positionAt(row), let content = contents.at(column) {
//                    addAnimation(TransitionAnimation(content: content, destination: position,
//                                                     duration: 2.0, damping: 1.0), forPage: row)
//                }
//            }
//        }
        
        let groundView = UIView(frame: CGRect(x: 0, y: 0, width: 1024, height: 60))
        groundView.backgroundColor = UIColor.black //UIColor(hex: "FFCD41")
        let groundContent = Content(view: groundView,
                                    position: Position(left: 0.0, bottom: 0.068), centered: false)
        contents.append(groundContent)
        
        addToBackground([groundContent])
    }
    
    func configureForeground() {

        let foregroundContents = [
            ForegroundContent(name: "foreground0", left: 0.0, top: 0.2 + fineAdjustment, speed: -1.0),
            ForegroundContent(name: "foreground0", left: 1.0, top: 0.2 + fineAdjustment, speed: -1.0),
            ForegroundContent(name: "foreground0", left: 2.0, top: 0.2 + fineAdjustment, speed: -1.0),
            ForegroundContent(name: "foreground0", left: 3.0, top: 0.2 + fineAdjustment, speed: -1.0),
            ForegroundContent(name: "foreground0", left: 4.0, top: 0.2 + fineAdjustment, speed: -1.0),
            ForegroundContent(name: "foreground0", left: 5.0, top: 0.2 + fineAdjustment, speed: -1.0),
        ]
        
        var contents = [Content]()
        
        for foregroundContent in foregroundContents {
            let imageView = UIImageView(image: UIImage(named: foregroundContent.name))
            if let position = foregroundContent.positionAt(0) {
                contents.append(Content(view: imageView, position: position, centered: false))
            }
        }

        let foregroundButtons = [
            ForegroundContent(name: "Comprar e Jogar!", left: 0.16, top: 0.7 + fineAdjustment, speed: -1.0),
            ForegroundContent(name:           "Jogar!", left: 1.16, top: 0.7 + fineAdjustment, speed: -1.0),
            ForegroundContent(name: "Comprar e Jogar!", left: 2.16, top: 0.7 + fineAdjustment, speed: -1.0),
            ForegroundContent(name: "Comprar e Jogar!", left: 3.16, top: 0.7 + fineAdjustment, speed: -1.0),
            ForegroundContent(name: "Comprar e Jogar!", left: 4.16, top: 0.7 + fineAdjustment, speed: -1.0),
            ForegroundContent(name: "Comprar e Jogar!", left: 5.16, top: 0.7 + fineAdjustment, speed: -1.0),
            ]

        var buttonContents = [Content]()
        
        for foregroundButton in foregroundButtons {
            let buyOrPlayButton = UIButton(frame: CGRect(x: 0, y: 0, width: 240.0, height: 50.0))
            buyOrPlayButton.layer.cornerRadius = 26
            buyOrPlayButton.layer.borderWidth = 2
            // TODO: Customize the button border color according to the image predominant dark color
            buyOrPlayButton.layer.borderColor = customNQBlue.cgColor
            buyOrPlayButton.titleLabel!.font = UIFont(name: "Montserrat-Bold", size: 15.0)
            buyOrPlayButton.setTitleColor(customNQBlue, for: .normal)
            buyOrPlayButton.setTitle(foregroundButton.name, for: .normal)
            
            if let position = foregroundButton.positionAt(0) {
                buttonContents.append(Content(view: buyOrPlayButton, position: position, centered: false))
            }
        }

        for row in 1...4 {
            for (column, foregroundContent) in foregroundContents.enumerated() {
                if let position = foregroundContent.positionAt(row), let content = contents.at(column) {
                    addAnimation(TransitionAnimation(content: content, destination: position,
                                                     duration: 2.0, damping: 1.0), forPage: row)
                    self.addGradient(from: self.customNQBlue, to: UIColor.black)
                    print("passou tentativa!")
                }
            }
        }

        for row in 1...4 {
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
    
    func callSegueFromCell(myData dataobject: AnyObject) {
        let myStoryboard = UIStoryboard(name : "Main" , bundle: nil)
        let loadingViewController = myStoryboard.instantiateViewController(withIdentifier: "LoadingVC") as! LoadingContentViewController

        self.navigationController?.pushViewController(loadingViewController, animated: true)
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
