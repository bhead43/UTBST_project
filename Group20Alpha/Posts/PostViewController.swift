//
//  PostViewController.swift
//  Group20Alpha
//
//  Created by Brandon Head on 4/25/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    var post: Post?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = post!.postTitle
        descriptLabel.text = post!.postDescription
        priceLabel.text = post!.postPrice

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

}
