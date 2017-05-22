//
//  CategoryModel.swift
//  DemoExpandingCollection
//
//  Created by Luiz Dias on 6/18/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    dynamic var id = "0"
    dynamic var name = " "
    dynamic var image = " "
    dynamic var isActive = true
    dynamic var available  = true
    dynamic var hashDaCategoria = " "
    dynamic var version = " "
    dynamic var price = " "
}