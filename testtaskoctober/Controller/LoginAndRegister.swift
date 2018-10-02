//
//  ViewController.swift
//  testtaskoctober
//
//  Created by shady on 10/1/18.
//  Copyright © 2018 XYZ. All rights reserved.
//

import UIKit

import Firebase


class LoginAndRegister: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    
    
    
    
    

    @IBAction func loginAction(_ sender: Any) {
 
    
        Auth.auth().signIn(withEmail: userName.text!, password: password.text!) { (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                print("Log in successful!")
                
          
                
                self.performSegue(withIdentifier: "goToData", sender: self)
                
            }
            
        }
    
    }
    
    
    // first enable auth from firebase dashboard
    	
    
    
    @IBAction func registerAction(_ sender: Any) {
      //use func auth to create user in firebase
        // we will use segue to goto the next view controller 
        
       Auth.auth().createUser(withEmail: userName.text!, password: password.text!) { (user, error) in
            
            if error != nil {
               print(error!)
           } else {
               print("Registration Successful!")
                
                
              self.performSegue(withIdentifier: "goToData", sender: self)
        }
        }
        
        
    }
    
}

