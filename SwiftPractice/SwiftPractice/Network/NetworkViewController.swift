//
//  NetworkViewController.swift
//  SwiftPractice
//
//  Created by lizhu on 15/11/11.
//  Copyright © 2015年 zhuli. All rights reserved.
//

import UIKit

class NetworkViewController: UIViewController {
    
    //MARK: getters and setters
    var btn:UIButton?

    //MARK: life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btn=UIButton()
        btn?.setTitle("点我", forState: UIControlState.Normal)
        btn!.addTarget(self, action: Selector("buttonClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        btn!.frame=CGRectMake(10, 40, 100, 40)
        view.addSubview(btn!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: event response
    //https://api.github.com/search/users?q=tom
    func buttonClick(sender: UIButton) {
        Network.request("GET", url: "https://api.github.com/search/users",params: ["q":"tom"]) { (data, response, error) -> Void in
            if let d=data{
                let string = NSString(data: d, encoding: NSUTF8StringEncoding)
                print(string)
            }
        }
    }

}
