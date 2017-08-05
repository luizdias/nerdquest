//
//  LoadingContentViewController.swift
//  DemoExpandingCollection
//
//  Created by Luiz Fernando Dias on 9/30/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit
import UIImageColors
import SwiftyJSON
//import Alamofire
import SwiftyGif

class LoadingContentViewController: UIViewController, APIProtocol {
    
    @IBOutlet weak var gradientOverlay: UIImageView!
    @IBOutlet weak var loadingImageView: UIImageView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var getReady: UILabel!
    private var backgroundColor =  UIColor()
    private var mainLabelColor = UIColor()
    private var secondaryLabelColor = UIColor()
    private var detailLabelColor = UIColor()
    private var myAPI = API()
    private var networkingDidFinish = false
    private var questionList: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Starting with the http request to retrieve questions:
//        myAPI.get(path: "/57b8cefa1100009e108dee1c", delegate: self)
        myAPI.getLocalFrom(filename: "CategoryMedieval", delegate: self)
        self.status.text = "Carregando as perguntas..."
        startTimer()
        
        // MARK: UIImageColors
        // TODO: Check if there's some for to extract the colors from the image again
        let imageSample = UIImage(named: "item2.png")
        let imageWidth = imageSample?.size.width
        let imageHeight = imageSample?.size.height
        //        let colorsFromImage = imageSample?.getColors(scaleDownSize: CGSize(width: imageWidth!, height: imageHeight!))
        _ = imageSample?.getColors(scaleDownSize: CGSize(width: imageWidth!, height: imageHeight!), completionHandler: { (colors) in
            
            self.backgroundColor = colors.backgroundColor
            self.mainLabelColor = colors.primaryColor
            self.secondaryLabelColor = colors.secondaryColor
            self.detailLabelColor = colors.detailColor
        })
        
        let gifmanager = SwiftyGifManager(memoryLimit:20)
        let gif = UIImage(gifName: "preloader")
        self.loadingImageView.setGifImage(gif, manager:gifmanager)
//        let imageview = UIImageView(gifImage: gif, manager: gifManager)
//        imageview.frame = CGRect(x: 0.0, y: 5.0, width: 400.0, height: 200.0)
//        view.addSubview(imageview)
//        let frame = self.gradientOverlay.frame
//        let thatBlue = UIColor(red: 26.0, green: 24.0, blue: 66.0, alpha: 1.0)
//        let img = UIImage.multiply(image: #imageLiteral(resourceName: "gradientBackground"), color: thatBlue, alpha: 1.0)
//        img.draw(in: frame, blendMode: .multiply, alpha: 0.2)
//        self.gradientOverlay.image = img
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        self.status.text = "Montando sequência..."
        
        if segue.identifier == "questionsSegue" {
            let questionsView = segue.destination as! QuestionsViewController
//            questionsView.backgroundColor = self.backgroundColor
//            questionsView.mainLabelColor = self.mainLabelColor
//            questionsView.secondaryLabelColor = self.secondaryLabelColor
//            questionsView.detailLabelColor = self.detailLabelColor
            questionsView.questionList = self.questionList
        }
    }
    
    private var counter = 0
    private var timer = Timer()
    
    func startTimer() {
        timer.invalidate() // just in case this button is tapped multiple times
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    // stop timer
    func cancelTimer(){
        timer.invalidate()
    }
    
    // called every time interval from the timer
    func timerAction() {
        counter += 1
        print("\(counter)")
        
        if counter >= 2 {
            self.getReady.text = "Vamos lá!"
        }
        
        //TODO: Fix the counter == 5 back when in RELEASE mode.
        if counter >= 4 {
            self.status.text = "Embaralhando as respostas..."
            if networkingDidFinish{
                cancelTimer()
                let myStoryboard = UIStoryboard(name : "Main" , bundle: nil)
                let questionsViewController = myStoryboard.instantiateViewController(withIdentifier: "questionsVC") as! QuestionsViewController
                questionsViewController.questionList = self.questionList
                self.navigationController?.pushViewController(questionsViewController, animated: true)
//                self.performSegue(withIdentifier: "questionsSegue", sender:self)
            }
        }
        if counter >= 10 {
            // Show message after 10 seconds waiting for the network response.
            let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
            self.status.text = "Problemas ao conectar ao servidor..."
            alert.title = "Oops! 😮"
            alert.message = "A conexão parece estar offline."
        }
    }
    
    func didReceiveResult(results: JSON) {
    
        networkingDidFinish = true
        self.status.text = "Carregando perguntas: Sucesso!"
        let questions: NSMutableArray = []
        print("Categories.didReceiveResult: \(results)")
        
        for (_,subJson):(String, JSON) in results {
            let question = Question()
            question.id = subJson["id"].stringValue
            question.text = subJson["title"].stringValue
            question.isMultiple = subJson["isMultiple"].boolValue
            question.isActive = subJson["isActive"].boolValue
            question.level = subJson["level"].intValue
            question.isTrueFalse = subJson["isTrueFalse"].boolValue
            //            question.answers = <Answer>()
            
            let answersSubJson = subJson["answers"]
            var answers = Set<Answer>()
            for (_, subSubJson):(String, JSON) in answersSubJson {
                let answer = Answer()
                answer.id = subSubJson["id"].stringValue
                answer.text = subSubJson["text"].stringValue
                answer.sourceURL = subSubJson["sourceURL"].stringValue
                answer.isActive = subSubJson["isActive"].boolValue
                answer.isCorrect = subSubJson["isCorrect"].boolValue
                answers.insert(answer)
                question.answers.insert(answer, at: (subSubJson["id"].intValue)-1)
            }
            questions.add(question)
        }

        questionList = questions
        print("Quantidade de questões after parse: \(questionList.count)")

//        // Make sure we are on the main thread, and update the UI.
//        DispatchQueue.main.async(execute: {
//            self.tableView.reloadData()
//        })

    }
    
    func didErrorHappened(error: NSError) {
        self.hideHUD()
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
        if let message = error.userInfo["message"]{
            print("\((message as AnyObject).description)")
            alert.title = "Oops! 😮"
            alert.message = message as? String
            //Cleaning our questions and answers dic.
            questionList = []
        }else {
            alert.title = "Erro"
            alert.message = "Há um problema na conexão com o nosso servidor. Tente novamente mais tarde (1011)."
        }
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
