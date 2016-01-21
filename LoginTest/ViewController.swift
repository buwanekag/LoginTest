//
//  ViewController.swift
//  LoginTest
//
//  Created by Buwaneka Galpoththawela on 1/20/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit
import HMACSigner

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    var baseUrlString = "medlink-staging.herokuapp.com"
    
    //MARK: - Interactive Method 
    
    //MARK: - Authenticate Login Method
    
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        if username!.isEmpty || password!.isEmpty {
            //loginButton.hidden = true
        let alert = UIAlertController(title: "Error", message: "fields are empty", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil ))
            self.presentViewController(alert, animated: true, completion: nil )
            
        } else {
            let url = NSURL(string: "https://\(baseUrlString)/api/v1/auth")
            
            let request = NSMutableURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 30.0)
            request.HTTPMethod = "POST"
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = "email=\(username)&password=\(password)".dataUsingEncoding(NSUTF8StringEncoding)
            
            request.signWithAccessIdentifier("2376", andSecret: "HLHSDDp+95IqeCuAjCslZRqRcPdnRXFd55W904lamDMQh9pa+UIrNRz+hiPpg5u7FKKPF5GjQPEPSWYbzbGbpw==")
            let urlSession = NSURLSession.sharedSession()
           
            let task = urlSession.dataTaskWithRequest(request, completionHandler: { (data ,response,error ) -> Void in
                print("response\(response)")
                
            })
            task.resume()
        }
    }
    
    //MARK: - Parse and store response
    
    //MARK: - Life Cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
           }


}

