//
//  ViewController.swift
//  UpDownGame
//
//  Created by sdt5 on 2015. 10. 20..
//  Copyright © 2015년 tacademy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var count = 5
    var random : UInt32 = arc4random()%10+1
    
    
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var result: UILabel!
    
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
    }
    
    @IBAction func enterNumber(sender: UIButton) {
        var msg = ""
        
        count--
        guard count>0 else {
            result.text = "정답은 \(random)입니다"
            return
        }
        
        if random > UInt32(text.text!) {
            result.text = "DOWN : \(count)회 남음"
            msg = "선택한 숫자가 더 적습니다"
        } else if random < UInt32(text.text!) {
            result.text = "UP : \(count)회 남음"
            msg = "선택한 숫자가 더 큽니다"
        } else {
            result.text = "SUCCESS"
            msg = "정답!"
        }
        
        text.text = ""
        
        let dialog = UIAlertController(title : "결과", message : "\(msg)", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title : "OK", style: UIAlertActionStyle.Default) { (action) -> Void in print("OK 선택") }
        dialog.addAction(okAction)
        
        self.presentViewController(dialog, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

