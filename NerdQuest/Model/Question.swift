//
//  QuestionModel.swift
//  DemoExpandingCollection
//
//  Created by Luiz Dias on 6/18/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import Foundation
import RealmSwift

class Question: Object {
    dynamic var id = "0"
    dynamic var text = ""
    dynamic var isMultiple = true
    dynamic var isTrueFalse = false
    dynamic var isActive = true
    dynamic var level = 2
    let answers = List<Answer>()
}
