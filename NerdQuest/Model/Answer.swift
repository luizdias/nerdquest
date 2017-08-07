//
//  AnswerModel.swift
//  DemoExpandingCollection
//
//  Created by Luiz Dias on 6/18/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import Foundation
import RealmSwift

class Answer: Object {
    
    dynamic var id = String()
    dynamic var text = String()
    dynamic var isCorrect = Bool()
    dynamic var sourceURL = String()
    dynamic var isActive = Bool()
}
