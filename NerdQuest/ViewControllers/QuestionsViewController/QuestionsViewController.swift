//
//  QuestionsViewController.swift
//  DemoExpandingCollection
//
//  Created by Luiz Dias on 6/4/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AnswersViewControllerDelegate, NavigationControllerBackButtonDelegate {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var answersViewContainer: UIView!
    
    @IBOutlet weak var answersViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoBarButton: UIBarButtonItem!
    
    @IBAction func infoAboutTheQuestion(_ sender: UIBarButtonItem) {
        UIApplication.shared.openURL(URL(string: "http://www.stackoverflow.com")!)
    }
    
    var questionList: NSMutableArray = []
    var backgroundColor = UIColor.white
    var mainLabelColor = UIColor.white
    var secondaryLabelColor = UIColor.white
    var detailLabelColor = UIColor.white
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hiding the question to allow the fade in effect.
//        self.questionLabel.alpha = 0.0
        let white = UIColor(red: 100.0, green: 100.0, blue: 100.0, alpha: 100.0)
        let black = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        let mainLabelColorCopy = self.mainLabelColor
        let clear = UIColor.clear
        self.navigationController?.navigationBar.tintColor = white
//        self.setGradientBackground(colorTop: black, colorBottom: mainLabelColorCopy)
//        let transparentButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
//        transparentButton.backgroundColor = clear
//        transparentButton.setTitle("< Sair", for: .normal)
//        transparentButton.addTarget(self, action: #selector(backAction), for: UIControlEvents.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Sair", style: .done, target: self, action: #selector(backAction))
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Done, target: self, action: #selector(self.backToInitial(sender:)))

//        self.navigationController?.navigationBar.addSubview(transparentButton)
        infoBarButton.isEnabled = false
        infoBarButton.tintColor = UIColor.clear
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        answersViewContainer.center.y +=  view.bounds.height
        
        self.questionLabel.pushTransition(duration: 1.4)
//        fadeViewInThenOut(label: self.questionLabel, delay: 0.5)
//        answersViewBottomConstraint.constant -= view.bounds.height
//        answersView.hidden = true
//        UIView.setAnimationsEnabled(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:AnswerOptionTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath as IndexPath) as! AnswerOptionTableViewCell

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "answersSegue" {
            let answersView = segue.destination as! AnswersViewController
            answersView.delegate = self
            answersView.questionList = self.questionList
            self.addChildViewController(answersView)
            answersView.view.frame = CGRect(x: 0, y: 0, width: self.answersViewContainer.frame.size.width, height: self.answersViewContainer.frame.size.height)
            answersView.didMove(toParentViewController: self)

            self.view.addSubview(self.answersViewContainer)
            UIView.animate(withDuration: 1.0, delay: 0.3, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.answersViewContainer.center.y -= self.view.bounds.height
            }) { (finished) in
                self.view.addSubview(self.answersViewContainer)
            }
        }
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        
        self.view.backgroundColor = UIColor.clear
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0.0, 0.5]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    // AnswersViewController Delegates here:
    func questionText(text: String) {
        questionLabel.text = text
        questionLabel.pushTransition(duration: 0.8)
    }

    func backAction() {
        for view in (self.navigationController?.viewControllers)! {
            if view is CategoriesCardViewController{
                let viewToPop = view as! CategoriesCardViewController
                self.navigationController?.popToViewController(viewToPop, animated: true)
            }
        }
    }
    
    func shouldPopOnBackButtonPress() -> Bool {
        self.backAction()
        return false
    }
    
    func fadeViewInThenOut(label : UILabel, delay: TimeInterval) {
        
        let animationDuration = 0.25
        
        // Fade in the label
        UILabel.animate(withDuration: animationDuration, animations: { () -> Void in
            label.alpha = 0
        }) { (Bool) -> Void in
            
            // After the animation completes, fade out the view after a delay
            
            UILabel.animate(withDuration: animationDuration, delay: delay, options: .curveEaseInOut, animations: { () -> Void in
                label.alpha = 1
            },completion: nil)
        }
    }
}


// Usage: insert view.pushTransition right before changing content
extension UILabel {
    func pushTransition(duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromTop
        animation.duration = duration
        self.layer.add(animation, forKey: kCATransitionPush)
    }
}
