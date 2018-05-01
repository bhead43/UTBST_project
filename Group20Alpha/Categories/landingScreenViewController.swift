//
//  landingScreenViewController.swift
//  Group20Alpha
//
//  Created by Ashley Moore on 4/29/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

import Foundation
import UIKit

class landingScreenViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        logoutButton.backgroundColor = UIColor.blue
        
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func logoutPressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
