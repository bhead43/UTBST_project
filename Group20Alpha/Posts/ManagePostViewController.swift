//
//  ManagePostViewController.swift
//  Group20Alpha
//
//  Created by Brandon Head on 4/29/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

import UIKit
import Firebase

class ManagePostViewController: UIViewController {
    var ref: DatabaseReference!
    var currentPost: Post?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        //something something key.removeValues()
        let currentKey = currentPost?.postID
        let currentCat = currentPost?.postCategory
        print(currentKey!)
        
        ref = Database.database().reference().child(currentCat!).child(currentKey!)
        
        ref.removeValue { error, _ in

            print(error)
        }
    }
}
