//
//  AnswersViewController.swift
//  DemoExpandingCollection
//
//  Created by Luiz Fernando Dias on 6/5/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import UIKit
import TKSwarmAlert
import SwiftyJSON

class AnswersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Dimmable {

    @IBOutlet weak var tableView: UITableView!
    
//    let swAlert = TKSwarmAlert(backgroundType: .transparentBlack(alpha: 0.5))
    private let swAlertWon = TKSwarmAlert(backgroundType: .brightBlur)
    private let swAlertLose = TKSwarmAlert(backgroundType: .blur)
    
    private let dimLevel: CGFloat = 0.5
    private let dimSpeed: Double = 0.2
    var delegate:AnswersViewControllerDelegate?
    private var tableData = [""]
    private var rightAnswer = 0
    
    public var questionList: NSMutableArray = []
    var questionListShuffled: NSMutableArray = []
    var activeQuestionIndex = 0
    var numberOfQuestionsInCategory = 1
    
    private var questionFromShuffledList = Question()
    private var shuffledAnswers: [Answer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideHUD()
//        self.showHUD()
        self.view.clipsToBounds = true
        self.view.layer.cornerRadius = 12
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        swAlertWon.didDissmissAllViews = {
            
            // Controls the END and BEGINING of a set of questions
            // If there's more questions, load the next one!
            if self.activeQuestionIndex+1 < self.numberOfQuestionsInCategory{
                self.activeQuestionIndex += 1
                self.questionFromShuffledList = self.questionListShuffled[self.activeQuestionIndex] as! Question
                self.shuffledAnswers = self.questionFromShuffledList.answers.shuffled()
                self.tableView.reloadData()
                UIView.transition(with: super.view, duration: 1.0, options: .transitionFlipFromLeft, animations: {
                    //animations goes here
                }, completion: { (Bool) in
                    //completion goes here. Perhaps:
                    //self.tableView.realoadData()
                })
            }else {
                //User reached the end of the questions set of this category. 
                self.finishRound()
            }
        }
        
        swAlertLose.didDissmissAllViews = {
            // Controls the END and BEGINING of a set of questions
            // If there's more questions, load the next one!
            if self.activeQuestionIndex+1 < self.numberOfQuestionsInCategory{
                self.activeQuestionIndex += 1
                self.questionFromShuffledList = self.questionListShuffled[self.activeQuestionIndex] as! Question
                self.shuffledAnswers = self.questionFromShuffledList.answers.shuffled()
                self.tableView.reloadData()
                UIView.transition(with: super.view, duration: 1.0, options: .transitionFlipFromLeft, animations: {
                    //animations goes here
                }, completion: { (Bool) in
                    //completion goes here. Perhaps:
                    //self.tableView.realoadData()
                })
            }else {
                //User reached the end of the questions set of this category.
                self.finishRound()
            }
        }
        
        if self.questionListShuffled.count == 0{
            self.questionListShuffled.addObjects(from: self.questionList.shuffled() as! [Question])
        }
        self.numberOfQuestionsInCategory = self.questionListShuffled.count
        self.questionFromShuffledList = self.questionListShuffled[self.activeQuestionIndex] as! Question
        self.shuffledAnswers = self.questionFromShuffledList.answers.shuffled()
    }
    
    //MARK: TableView Delegates
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let cell:AnswerOptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! AnswerOptionTableViewCell
        print("indice=\(indexPath)")
        
        let decorativeBar = cell.viewWithTag(1)!
        
        switch indexPath.row {
        case 0:
            decorativeBar.backgroundColor = UIColor.blue
        case 1:
            decorativeBar.backgroundColor = UIColor.brown
        case 2:
            decorativeBar.backgroundColor = UIColor.cyan
        case 3:
            decorativeBar.backgroundColor = UIColor.green
        default:
            decorativeBar.backgroundColor = UIColor.white
        }
        
        let answer = self.shuffledAnswers[indexPath.row]
        cell.answerOptionLabel.text = answer.text
        if (delegate != nil){
            delegate!.questionText(text: questionFromShuffledList.text)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var viewsToPopOver = [UIView]()
        let selectedAnswer = self.shuffledAnswers[indexPath.row]
        // Present different Popovers according to results (if the awswer is right or wrong)
        if  selectedAnswer.isCorrect {
            let popoverPoints = (self.storyboard?.instantiateViewController(withIdentifier: "Result"))! as UIViewController
            viewsToPopOver.append(popoverPoints.view!)
            RoundManager.shared().correctAnswer()
            swAlertWon.show(viewsToPopOver)
        } else {
            let popoverAnswerResult = (self.storyboard?.instantiateViewController(withIdentifier: "WrongAnswer"))! as UIViewController
            viewsToPopOver.append(popoverAnswerResult.view!)
            RoundManager.shared().wrongAnswer()
            swAlertLose.show(viewsToPopOver)
        }
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        dim(direction: .In, alpha: dimLevel, speed: dimSpeed)
    }

    @IBAction func unwindFromSecondary(segue: UIStoryboardSegue) {
        dim(direction: .Out, speed: dimSpeed)
    }
    
    
    //TODO:  The two Functions bellow are DEPRECATED:
    func didErrorHappened(error: NSError) {
        self.hideHUD()
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
        if let message = error.userInfo["message"]{
            print("\((message as AnyObject).description)")
            alert.title = "Oops! 😮"
            alert.message = message as? String
            questionList = []
            self.tableView.reloadData()
        }else {
            alert.title = "Erro"
            alert.message = "Há um problema na conexão com o nosso servidor. Tente novamente mais tarde (1011)."
        }
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func didReceiveResult(results result: JSON) {
        self.hideHUD()
        let questions: NSMutableArray = []
        
        NSLog("Categories.didReceiveResult: \(result)")
        
        for (_,subJson):(String, JSON) in result {
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
        questionListShuffled = questionList.shuffled() as! NSMutableArray
        print("Quantidade de questões after parse: \(questionList.count)")
        self.numberOfQuestionsInCategory = questionList.count
        
        // Make sure we are on the main thread, and update the UI.
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
        
        self.hideHUD()
    }
    
    func finishRound() {
        let myStoryboard = UIStoryboard(name : "Main" , bundle: nil)
        let finishedRoundVC = myStoryboard.instantiateViewController(withIdentifier: "finishedRoundViewController") as! FinishedRoundViewController
        self.navigationController?.pushViewController(finishedRoundVC, animated: true)
        //        self.present(finishedRoundVC, animated: true, completion: nil)
    }

}

//MARK: AnswersViewController Delegate definition
protocol AnswersViewControllerDelegate {
    func questionText(text: String)
//    func networkingDidFinish()
}


extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
