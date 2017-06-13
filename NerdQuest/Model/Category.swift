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
    
    // MARK: - Public API
    dynamic var id = "0"
    dynamic var tag = ""
    dynamic var image=NSData()
    dynamic var isActive = true
    dynamic var available = true
    dynamic var hashDaCategoria = ""
    dynamic var version = ""
    dynamic var price = ""
    dynamic var numberOfMembers = 0
    dynamic var numberOfPosts = 0
    dynamic var title = ""
    dynamic var details = ""
    
    convenience init(title: String, details: String, image: NSData!)
    {
        self.init()
        self.title = title
        self.details = details
        self.image = image
        numberOfMembers = 1
        numberOfPosts = 1
    }
    
    // MARK: - Private
    // dummy data
    static func createCategories() -> [Category]
    {
        if let tempImage = UIImage(named: "image"){
            let tempImageDataBefore = UIImagePNGRepresentation(tempImage)
            let tempImageData = NSData(data: tempImageDataBefore!)
//            let tempImageData = NSData(UIImagePNGRepresentation(_ tempImage)
            return [
                Category(title: "Medieval", details: "A set of questions that test your knowledge about medieval stuff!", image: tempImageData),
                Category(title: "Videogames", details: "Do you  call yourself the master of games? Check these questions. You're gonna call yourself a noobie again ;)", image: tempImageData),
                Category(title: "Retro games", details: "Do you  call yourself the master of games? Check these questions. You're gonna call yourself a noobie again ;)", image: tempImageData),
                Category(title: "Sci-fi", details: "Do you  call yourself the master of games? Check these questions. You're gonna call yourself a noobie again ;)", image: tempImageData),
                Category(title: "Medieval", details: "A set of questions that test your knowledge about medieval stuff!", image: tempImageData),
                Category(title: "Videogames", details: "Do you  call yourself the master of games? Check these questions. You're gonna call yourself a noobie again ;)", image: tempImageData),
                Category(title: "Retro games", details: "Do you  call yourself the master of games? Check these questions. You're gonna call yourself a noobie again ;)", image: tempImageData),
                Category(title: "Sci-fi", details: "Do you  call yourself the master of games? Check these questions. You're gonna call yourself a noobie again ;)", image: tempImageData),
                Category(title: "Medieval", details: "A set of questions that test your knowledge about medieval stuff!", image: tempImageData),
                Category(title: "Videogames", details: "Do you  call yourself the master of games? Check these questions. You're gonna call yourself a noobie again ;)", image: tempImageData),
                Category(title: "Retro games", details: "Do you  call yourself the master of games? Check these questions. You're gonna call yourself a noobie again ;)", image: tempImageData),
                Category(title: "Sci-fi", details: "Do you  call yourself the master of games? Check these questions. You're gonna call yourself a noobie again ;)", image: tempImageData),
            ]
        }else {
            return []
        }
    }
}
