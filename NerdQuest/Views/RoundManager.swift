//
//  RoundManager.swift
//  NerdQuest
//
//  Created by Luiz Fernando Aquino Dias on 04/08/17.
//  Copyright © 2017 Town Tree. All rights reserved.
//

import UIKit

class RoundManager {

    // MARK: - Properties
    private var counter = 0
    private var start = Date()
    private var correctAnswers: Int = 0
    private var wrongAnswers: Int = 0
    private var finalTime: String = ""

    struct RoundStats {
        var correct = 0
        var wrong = 0
        var time = ""
    }
    
    private static var sharedRoundManager: RoundManager = {
        let roundManager = RoundManager()
        
        // Configuration
        // ...
        
        return roundManager
    }()

    func startCounter() {
        self.start = Date()
    }
    
    // stop counter
    func stopCounter(){
        print("Elapsed time: \(start.timeIntervalSinceNow) seconds")
        self.finalTime =  start.timeIntervalSinceNow.timeIntervalAsString()
    }
    
    func correctAnswer(){
        self.correctAnswers += 1
    }
    
    func wrongAnswer(){
        self.wrongAnswers += 1
    }
    
    func getStats() -> RoundStats{
        stopCounter()
        return RoundStats(correct: self.correctAnswers, wrong: self.wrongAnswers, time: self.finalTime)
    }
    
    func resetRound(){
        self.correctAnswers = 0
        self.wrongAnswers = 0        
    }
    
    // MARK: - Accessors
    class func shared() -> RoundManager {
        return sharedRoundManager
    }
    
}

extension TimeInterval {
//    func timeIntervalAsString(_ format : String = "dd days, hh hours, mm minutes, ss seconds, sss ms") -> String {
    func timeIntervalAsString(_ format : String = "xxmyys") -> String {
        var asInt   = NSInteger(self)
        let ago = (asInt < 0)
        if (ago) {
            asInt = -asInt
        }
//        let ms = Int(self.truncatingRemainder(dividingBy: 1) * (ago ? -1000 : 1000))
        let s = asInt % 60
        let m = (asInt / 60) % 60
//        let h = ((asInt / 3600))%24
//        let d = (asInt / 86400)
        
        var value = format
//        value = value.replacingOccurrences(of: "hh", with: String(format: "%0.2d", h))
        value = value.replacingOccurrences(of: "xx",  with: String(format: "%0.2d", m))
//        value = value.replacingOccurrences(of: "sss", with: String(format: "%0.3d", ms))
        value = value.replacingOccurrences(of: "yy",  with: String(format: "%0.2d", s))
//        value = value.replacingOccurrences(of: "dd",  with: String(format: "%d", d))
        if (ago) {
            value += ""
        }
        return value
    }
    
}
