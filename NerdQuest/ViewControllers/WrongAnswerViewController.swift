//
//  WrongAnswerViewController.swift
//  NerdQuest
//
//  Created by Luiz Fernando Aquino Dias on 05/03/17.
//  Copyright © 2017 Town Tree. All rights reserved.
//

import UIKit

class WrongAnswerViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var questionDetailsLinkButton: UIButton!
    @IBOutlet weak var wrongAnswerMessageLabel: UILabel!
    
    @IBAction func wantMoreDetails(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: "http://www.stackoverflow.com")!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        popupView.backgroundColor = UIColor.white
        popupView.layer.cornerRadius = 12
        popupView.layer.borderColor = UIColor.black.cgColor
        popupView.layer.borderWidth = 0.25
        popupView.layer.shadowColor = UIColor.black.cgColor
        popupView.layer.shadowOpacity = 0.6
        popupView.layer.shadowRadius = 15
        popupView.layer.shadowOffset = CGSize(width: 5, height: 5)
        popupView.layer.masksToBounds = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
