//
//  ViewController.swift
//  UpDownGame
//
//  Created by sdt5 on 2015. 10. 20..
//  Copyright © 2015년 tacademy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var timeProgress: UIProgressView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var count = 5
    var random : UInt32 = arc4random()%10+1
    var timer: NSTimer!
    var i = 0
    
    @IBAction func chooseGame(sender: UISegmentedControl) {
        count = 5
        text.text = ""
        result.text = "START"
        
        switch sender.selectedSegmentIndex {
        case 0 : random = arc4random()%10+1
        case 1 : random = arc4random()%50+1
        default: random = arc4random()%100+1
        }
        print(random)
        
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
        
        startTime()
    }
    
    @IBAction func enterNumber(sender: UIButton) {
        count--
        guard count>0 else {
            result.text = "기회는 끝났습니다. 정답은 \(random)입니다"
            return
        }
        
        if random > UInt32(text.text!) {
            result.text = "DOWN : \(count)회 남음"
            if timer != nil {
                timer.invalidate()
                timer = nil
            }
            
            startTime()
        } else if random < UInt32(text.text!) {
            result.text = "UP : \(count)회 남음"
            if timer != nil {
                timer.invalidate()
                timer = nil
            }
            
            startTime()
        } else {
            result.text = "SUCCESS"
            
            let dialog = UIAlertController(title : "정답!", message : "정답입니다", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title : "OK", style: UIAlertActionStyle.Default) { (action) -> Void in print("OK 선택") }
            dialog.addAction(okAction)
            
            self.presentViewController(dialog, animated: true, completion: nil)
            
            if timer != nil {
                timer.invalidate()
                timer = nil
            }

        }
        
        text.text = ""
        
        
    }
    
    func startTime(){
        i=0
        let interval: NSTimeInterval = 1
        timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: "countDown:", userInfo: nil, repeats: true)
    }
    
    func countDown(timer: NSTimer) {
        guard count>0 else {
            result.text = "기회는 끝났습니다. 정답은 \(random)입니다"
            return
        }
        
        guard i<10 else {
            result.text = "시간 초과 / \(--count)회 남음"
            i=0
            return
        }
        
        i++
        print(i)
        timeProgress.setProgress(Float(i)*0.1, animated: true)
        timeLabel.text = "\(i)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startTime()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

