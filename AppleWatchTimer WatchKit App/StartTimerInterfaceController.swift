//
//  StartTimerInterfaceController.swift
//  AppleWatchTimer
//
//  Created by Boris Filipović on 4/13/15.
//  Copyright (c) 2015 Boris Filipović. All rights reserved.
//

import WatchKit
import Foundation


class StartTimerInterfaceController: WKInterfaceController {

    @IBOutlet weak var timerCircle1: WKInterfaceImage!
    @IBOutlet weak var timerCircle2: WKInterfaceImage!
    @IBOutlet weak var timerCircle3: WKInterfaceImage!
    @IBOutlet weak var timerCircle4: WKInterfaceImage!
    @IBOutlet weak var timerCircle5: WKInterfaceImage!
    
    var doneCircle = UIImage(named: "doneCircle.png")
    var currentCircle = UIImage(named: "currentCircle.png")
    
    var numberOfSets = 3
    var lengthOfSet = 30
    
    var timerIsRunning = false
    
    @IBOutlet weak var timerLabel: WKInterfaceLabel!
    @IBOutlet weak var activeSetTimerLabel: WKInterfaceLabel!
    
    // Counter ivars.
    var counter = 1
    var currentSetCounter = 1
    var activeSetCountdownTimer = 0
    
    // Timer.
    var timer = NSTimer()
    
    @IBAction func startTimer() {
        
        if timerIsRunning == false {
            timerIsRunning = true
            timerCircle1.setImageNamed("blankCircle.png")
            timerCircle2.setImageNamed("blankCircle.png")
            timerCircle3.setImageNamed("blankCircle.png")
            timerCircle4.setImageNamed("blankCircle.png")
            timerCircle5.setImageNamed("blankCircle.png")
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("handleTimer:"), userInfo: nil, repeats: true)
            timerCircle1.setImageNamed("currentCircle.png")
            activeSetCountdownTimer = lengthOfSet
            activeSetTimerLabel.setText("\(activeSetCountdownTimer)")
        }
    }
    
    func handleTimer(timer:NSTimer){
        
        var convCounter:String = convertTime(counter)
        
        if convCounter != "error"{
            activeSetCountdownTimer--
            activeSetTimerLabel.setText("\(activeSetCountdownTimer)")
            timerLabel.setText(convCounter)
        } else {
            stopTimer()
        }
        
        switch counter {
        case 1 * lengthOfSet:
            currentSetCounter++
            if currentSetCounter <= numberOfSets {
                activeSetCountdownTimer = lengthOfSet
                activeSetTimerLabel.setText("\(activeSetCountdownTimer)")
                timerCircle1.setImageNamed("doneCircle.png")
                timerCircle2.setImageNamed("currentCircle.png")
                counter++
            } else {
                stopTimer()
            }
        case 2 * lengthOfSet:
            currentSetCounter++
            if currentSetCounter <= numberOfSets {
                activeSetCountdownTimer = lengthOfSet
                activeSetTimerLabel.setText("\(activeSetCountdownTimer)")
                timerCircle2.setImageNamed("doneCircle.png")
                timerCircle3.setImageNamed("currentCircle.png")
                counter++
            } else {
                stopTimer()
            }
        case 3 * lengthOfSet:
            currentSetCounter++
            if currentSetCounter <= numberOfSets {
                activeSetCountdownTimer = lengthOfSet
                activeSetTimerLabel.setText("\(activeSetCountdownTimer)")
                timerCircle3.setImageNamed("doneCircle.png")
                timerCircle4.setImageNamed("currentCircle.png")
                counter++
            } else {
                stopTimer()
            }
        case 4 * lengthOfSet:
            currentSetCounter++
            if currentSetCounter <= numberOfSets {
                activeSetCountdownTimer = lengthOfSet
                activeSetTimerLabel.setText("\(activeSetCountdownTimer)")
                timerCircle4.setImageNamed("doneCircle.png")
                timerCircle5.setImageNamed("currentCircle.png")
                counter++
            } else {
                stopTimer()
            }
        case 5 * lengthOfSet:
            stopTimer()            
        default:
            counter++
        }
        
    }
    
    
    @IBAction func stopTimer() {
        timer.invalidate()
        timerIsRunning = false
        counter = 1
        currentSetCounter = 1
        activeSetCountdownTimer = 0
        timerLabel.setText("00:00")
        activeSetTimerLabel.setText("0")
    }
    
    func convertTime(paramTime:Int)->String{
        
        if paramTime < 10 {
            // Less than minute.
            return "00:0\(paramTime)"
        } else if paramTime < 3600 {
        
            var seconds:Double
            var minutes:Int
            
            seconds = fmod(Double(paramTime), Double(60)) // Calculate seconds
            minutes = paramTime/60 // Calculate minutes
            
            var writeMinutes = minutes > 9 ? "\(minutes)" : "0\(minutes)"
            var writeSeconds = seconds > 9 ? "\(Int(seconds))" : "0\(Int(seconds))"
            
            return "\(writeMinutes):\(writeSeconds)"
            
        } else {
            return "error"
        }
    }
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        // Read data from push and set them up.
        if let contexObj: AnyObject = context {
            numberOfSets = context!["numberOfSets"]  as! Int
            lengthOfSet = context!["setLength"] as! Int
        }
        
        timerLabel.setText("00:00")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        timer.invalidate()
        timerIsRunning = false
        counter = 1
    }

}
