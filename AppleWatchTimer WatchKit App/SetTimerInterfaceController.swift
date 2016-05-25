//
//  SetTimerInterfaceController.swift
//  AppleWatchTimer
//
//  Created by Boris Filipović on 4/15/15.
//  Copyright (c) 2015 Boris Filipović. All rights reserved.
//

import WatchKit
import Foundation


class SetTimerInterfaceController: WKInterfaceController {

    @IBOutlet weak var numberOfSetsLabel: WKInterfaceLabel!
    @IBOutlet weak var setLengthLabel: WKInterfaceLabel!
    @IBOutlet weak var myTimerButton: WKInterfaceButton!
    
    @IBOutlet weak var numberOfSetsSlider: WKInterfaceSlider!
    @IBOutlet weak var lengthOfSetsSlider: WKInterfaceSlider!
    
    var numberOfSets = 3
    var lengthOfSet = 30
    
    // NSUserDefaults
    var container = "group.com.borisfilipovic.supersetstimer"
    var defaults = NSUserDefaults()
    var nsdefaultsSetNumberExist = false
    var nsdefaultsSetLengthExist = false
    var numberOfSetsDefaults = 0
    var lengthOfSetDefaults = 0


    @IBAction func numberOfSetsSliderValueChanged(value: Float) {
        nsdefaultsSetNumberExist = false
        
        numberOfSets = Int(value) // Read value from slider.
        numberOfSetsLabel.setText("\(numberOfSets)") // Set value to label.
        
        // Check if slider is at zero.
        if numberOfSets == 0 {
            myTimerButton.setEnabled(false)
            numberOfSetsLabel.setTextColor(UIColor.redColor())
        } else {
            myTimerButton.setEnabled(true)
            numberOfSetsLabel.setTextColor(UIColor.yellowColor())
        }
    }
    
    @IBAction func setLengthSliderValueChanged(value: Float) {
        nsdefaultsSetLengthExist = false
        
        lengthOfSet = Int(value) // Read value from slider.
        setLengthLabel.setText("\(lengthOfSet)")
        
        // Check if slider is at zero.
        if lengthOfSet == 0 {
            myTimerButton.setEnabled(false)
            setLengthLabel.setTextColor(UIColor.redColor())
        } else {
            myTimerButton.setEnabled(true)
            setLengthLabel.setTextColor(UIColor.yellowColor())
        }
    }
    
    @IBAction func myTimerButtonPressed() {
        if (numberOfSets > 0) && (lengthOfSet > 0) {
            //var contextObj = ["numberOfSets":numberOfSets, "setLength":lengthOfSet]
            var contextObj = ["numberOfSets":nsdefaultsSetNumberExist ? numberOfSetsDefaults: numberOfSets, "setLength":nsdefaultsSetLengthExist ? lengthOfSetDefaults : lengthOfSet]
            pushControllerWithName("startTimerController", context: contextObj)
        } else {
            if numberOfSets == 0 {
                numberOfSetsLabel.setTextColor(UIColor.redColor())
            } else {
                setLengthLabel.setTextColor(UIColor.redColor())
            }
        }
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
//        timerFiredate = NSDate(timeInterval: 25, sinceDate: dt)
//        timer2 = NSTimer(fireDate: timerFiredate!, interval: 5, target: self, selector: Selector("startTimers"), userInfo: nil, repeats: false)
//        NSRunLoop.currentRunLoop().addTimer(timer2!, forMode: NSDefaultRunLoopMode)
        
        // Check if NSUSerDefaults exist!
        defaults = NSUserDefaults(suiteName: container)!
        if let nmbTmp1 = defaults.valueForKey("setsCount") as? Int{
            numberOfSetsDefaults = nmbTmp1
            numberOfSetsLabel.setText("\(numberOfSetsDefaults)")
            numberOfSetsSlider.setValue(Float(numberOfSetsDefaults))
            nsdefaultsSetNumberExist = true
        }
        
        if let nmbTmp2 = defaults.valueForKey("setsLength") as? Int{
            lengthOfSetDefaults = nmbTmp2
            setLengthLabel.setText("\(lengthOfSetDefaults)")
            lengthOfSetsSlider.setValue(Float(lengthOfSetDefaults))
            nsdefaultsSetLengthExist = true
        }
        
        if !nsdefaultsSetNumberExist {
            numberOfSetsLabel.setText("\(numberOfSets)") // Set value to label.
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
