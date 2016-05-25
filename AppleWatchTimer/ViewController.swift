//
//  ViewController.swift
//  AppleWatchTimer
//
//  Created by Boris Filipović on 4/8/15.
//  Copyright (c) 2015 Boris Filipović. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var container = "group.com.borisfilipovic.supersetstimer"
    
    var defaults = NSUserDefaults()
    
    // Get value from defaults.
    var numberOfSets:Int?
    var lengthOfSet:Int?
    
    // Number of sets settings.
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var mySliderValue: UISlider!
    
    // Length of set settings.
    @IBOutlet weak var setLengthLabel: UILabel!
    @IBOutlet weak var setLengthSlider: UISlider!
    @IBOutlet weak var finishedSetLengthLabel: UILabel!
    
    
    @IBAction func sliderValueChanged(sender: AnyObject) {
        myLabel.text = ("\(Int(mySliderValue.value))")
        
        defaults.setValue(Int(mySliderValue.value), forKey: "setsCount") // Save  number os sets.
        
    }
    
    @IBAction func setLengthSliderButtonPressed(sender: AnyObject) {
        finishedSetLengthLabel.text = ("\(Int(setLengthSlider.value))")
        
        defaults.setValue(Int(setLengthSlider.value), forKey: "setsLength")
    }
    
    @IBAction func saveChangesButtonPressed(sender: AnyObject) {
        // Save changes.
        defaults.synchronize()
    }
    
    @IBAction func restoreDefaultsButtonPressed(sender: AnyObject) {
        defaults.setValue(Int(3), forKey: "setsCount")
        defaults.setValue(Int(30), forKey: "setsLength")
        defaults.synchronize()
        
        myLabel.text = ("3")
        mySliderValue.value = Float(3)
        
        finishedSetLengthLabel.text = ("30")
        setLengthSlider.value = Float(30)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mySliderValue.continuous = false
        
        defaults = NSUserDefaults(suiteName: container)!
        
        // Customize slider look.
        mySliderValue.minimumTrackTintColor = UIColor.yellowColor()
        mySliderValue.maximumTrackTintColor = UIColor.whiteColor()
        
        setLengthSlider.minimumTrackTintColor = UIColor.yellowColor()
        setLengthSlider.maximumTrackTintColor = UIColor.whiteColor()
        
        // Get values from NSStandardDefaults.
        if let nmbTmp1 = defaults.valueForKey("setsCount") as? Int{
            numberOfSets = nmbTmp1
            myLabel.text = ("\(numberOfSets!)")
            mySliderValue.value = Float(numberOfSets!)
        }
        
        if let nmbTmp2 = defaults.valueForKey("setsLength") as? Int{
            lengthOfSet = nmbTmp2
            finishedSetLengthLabel.text = ("\(lengthOfSet!)")
            setLengthSlider.value = Float(lengthOfSet!)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        defaults.synchronize() // Sinc before app is terminated.
    }


}

