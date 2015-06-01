//
//  ViewController.swift
//  Gradebook
//
//  Created by Erik Owen on 5/5/15.
//  Copyright (c) 2015 Erik Owen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var loader: GradebookLoader?
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        println("Login button pressed");
    }
    @IBAction func testButtonPressed(sender: AnyObject) {
        println("Test button pressed");
        usernameInput.text = "test";
        passwordInput.text = "sadf35cx90";
        baseUrlInput.text = "https://users.csc.calpoly.edu/~bellardo/cgi-bin/test/grades.json";
        
    }
    
    
    @IBOutlet weak var cpImage: UIImageView!
    
    @IBOutlet weak var usernameInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var baseUrlInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*Sets the background image*/
        cpImage.image = UIImage(named: "cp_logo");
        
        /*Makes sure the password input is hidden*/
        passwordInput.secureTextEntry = true;
        
        self.title = "Cal Poly Login"
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        usernameInput.text = ""
        passwordInput.text = ""
        baseUrlInput.text = "https://users.csc.calpoly.edu/~bellardo/cgi-bin/grades.json"
        
        
    }
    
    func presentErrorPopUp() {
        let alertController = UIAlertController(title: "Wrong Base URL", message:
        "The base URL must be either https://users.csc.calpoly.edu/~bellardo/cgi-bin/grades.json or https://users.csc.calpoly.edu/~bellardo/cgi-bin/test/grades.json", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
    
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func presentLoginErrorPopUp() {
        let alertController = UIAlertController(title: "Login Error", message:
            "Sorry, the login credentials you provided were not recognized", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if identifier == "loginToSectionSegue" {
            println("Segue check worked!")
            println("default base url is: " + baseUrlInput.text);
            var baseURL = baseUrlInput.text
            var name = usernameInput.text
            var password = passwordInput.text
            
            if(baseURL != "https://users.csc.calpoly.edu/~bellardo/cgi-bin/grades.json" && baseURL != "https://users.csc.calpoly.edu/~bellardo/cgi-bin/test/grades.json") {
                
                presentErrorPopUp()
                
                return false;
            }
            else {
                if loader!.loginWithUsername(name, password: password, baseURL: baseURL) {
                    println("Auth worked!")
                    return true;
                }
                else {
                    println("Auth failed!")
                    presentLoginErrorPopUp()
                    return false;
                }
            }
        }
        
        return false;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "loginToSectionSegue" {
            let dest: SectionTableViewController = segue.destinationViewController as! SectionTableViewController
            dest.loader = loader
            
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

