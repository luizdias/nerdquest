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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationTitle = false
        
        view.backgroundColor = UIColor.darkGray //UIColor(hex: "FFBC00")
        
        configureSlides()
        configureBackground()
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
                cell.categoryTitleLabel.text = "LUIZ CATEGORY"
                cell.cellDelegate = self
//                let cell = CategoriesCollectionViewCell.instanceFromNib()
                let position = Position(left: 0.7, top: 0.50)
                
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
        let backgroundImages = [
            BackgroundImage(name: "image", left: 0.0, top: 0.743, speed: -0.3),
            BackgroundImage(name: "singleStar", left: 0.02, top: 0.77, speed: 0.25),
            BackgroundImage(name: "image", left: 1.3, top: 0.73, speed: -1.5),
            BackgroundImage(name: "face1", left: 0.0, top: 0.79, speed: -0.24),
            BackgroundImage(name: "rightAnswer", left: 0.0, top: 0.627, speed: -0.16),
            BackgroundImage(name: "singleStar", left: 0.0, top: 0.51, speed: -0.08),
            BackgroundImage(name: "face1", left: 0.0, top: 0.29, speed: 0.0),
            BackgroundImage(name: "Clouds", left: -0.415, top: 0.14, speed: 0.18),
            BackgroundImage(name: "Sun", left: 0.8, top: 0.07, speed: 0.0)
        ]
        
        var contents = [Content]()
        
        for backgroundImage in backgroundImages {
            let imageView = UIImageView(image: UIImage(named: backgroundImage.name))
            if let position = backgroundImage.positionAt(0) {
                contents.append(Content(view: imageView, position: position, centered: false))
            }
        }
        
        addToBackground(contents)
        
        for row in 1...4 {
            for (column, backgroundImage) in backgroundImages.enumerated() {
                if let position = backgroundImage.positionAt(row), let content = contents.at(column) {
                    addAnimation(TransitionAnimation(content: content, destination: position,
                                                     duration: 2.0, damping: 1.0), forPage: row)
                }
            }
        }
        
        let groundView = UIView(frame: CGRect(x: 0, y: 0, width: 1024, height: 60))
        groundView.backgroundColor = UIColor.blue //UIColor(hex: "FFCD41")
        let groundContent = Content(view: groundView,
                                    position: Position(left: 0.0, bottom: 0.068), centered: false)
        contents.append(groundContent)
        
        addToBackground([groundContent])
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "Start set of questions"{
//            let loadingView = segue.destination as! LoadingContentViewController
//        }
//    }
    
    func callSegueFromCell(myData dataobject: AnyObject) {
        let myStoryboard = UIStoryboard(name : "Main" , bundle: nil)
        let loadingViewController = myStoryboard.instantiateViewController(withIdentifier: "LoadingVC") as! LoadingContentViewController
//        self.present(finishedRoundVC, animated: true, completion: nil)
        self.navigationController?.present(loadingViewController, animated: true, completion: {})

        
        //try not to send self, just to avoid retain cycles(depends on how you handle the code on the next controller)
//        self.navigationController?.performSegue(withIdentifier: Constants.startSetSegue, sender: self)
//        self.performSegue(withIdentifier: Constants.startSetSegue, sender: dataobject)
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
