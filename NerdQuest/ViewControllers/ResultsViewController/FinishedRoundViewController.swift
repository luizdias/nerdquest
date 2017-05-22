//
//  FinishedRoundViewController.swift
//  NerdQuest
//
//  Created by Luiz Fernando Aquino Dias on 26/02/17.
//  Copyright © 2017 Town Tree. All rights reserved.
//

import UIKit

class FinishedRoundViewController: UIViewController {

    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var chooseNewCategoryButton: UIButton!
    @IBOutlet weak var lastRoundStats: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Localize string bellow:
//        playAgain.setTitle(NSLocalizedString("PLAY_AGAIN", comment: "Play the same category again."), for: .normal)
//        playAgain.backgroundColor = UIColor.init(red: 255.0/255, green: 0.0/255, blue: 121.0/255, alpha: 1.0)
        playAgainButton.layer.cornerRadius = 26
        playAgainButton.layer.borderWidth = 0
        playAgainButton.layer.borderColor = UIColor.black.cgColor
        
        //TODO: Localize string bellow:
//        chooseNewCategory.setTitle(NSLocalizedString("PICK_NEW_THEME", comment: "Pick new theme."), for: .normal)
//        chooseNewCategory.backgroundColor = UIColor.init(red: 255.0/255, green: 0.0/255, blue: 121.0/255, alpha: 1.0)
        chooseNewCategoryButton.layer.cornerRadius = 26
        chooseNewCategoryButton.layer.borderWidth = 0
        chooseNewCategoryButton.layer.borderColor = UIColor.black.cgColor
        
        playAgainButton.addTarget(self, action: #selector(playSameRoundAgain), for: .touchUpInside)
//        chooseNewCategory.addTarget(self, action: #selector(showAllCategories), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playSameRoundAgain() {
//        let segue = UIStoryboardSegue(identifier: "questionsSegue", source: self, destination: QuestionsViewController())
//        self.prepare(for: segue, sender: nil)
        self.performSegue(withIdentifier: "questionsSegue", sender:self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "questionsSegue" {
            _ = segue.destination as! QuestionsViewController
//            questionsView.backgroundColor = self.backgroundColor
//            questionsView.mainLabelColor = self.mainLabelColor
//            questionsView.secondaryLabelColor = self.secondaryLabelColor
//            questionsView.detailLabelColor = self.detailLabelColor
//            questionsView.questionList = self.questionList
        }
    }

//    func showAllCategories() {
//        let finishedRoundVC = FinishedRoundViewController()
//        
//        self.present(finishedRoundVC, animated: true, completion: nil)
//    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
