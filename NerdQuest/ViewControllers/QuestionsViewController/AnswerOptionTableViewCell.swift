//
//  AnswerOptionTableViewCell.swift
//  DemoExpandingCollection
//
//  Created by Luiz Dias on 6/5/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import UIKit

class AnswerOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var answerOptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.answerOptionLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // Configure the view for the selected state
        super.setSelected(selected, animated: animated)
    }
}
