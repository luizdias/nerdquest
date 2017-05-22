//
//  APIProtocol.swift
//  DemoExpandingCollection
//
//  Created by Luiz Dias on 6/20/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import Foundation
import SwiftyJSON

// Creating a protocol called APIProtocol
protocol APIProtocol {
    func didReceiveResult(results: JSON)
    func didErrorHappened(error: NSError)
}
