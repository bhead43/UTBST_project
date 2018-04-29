//
//  PostViewController.swift
//  Group20Alpha
//
//  Created by Brandon Head on 4/25/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController {

    var ref: DatabaseReference!
    var post: Post?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    @IBOutlet weak var userInputComments: UITextView!
    
    var comments: [String] = []
    @IBAction func addCommentsButton(_ sender: UIButton) {
        addComment()
    }
    
    func addComment(){
        let userID = Auth.auth().currentUser?.uid
        ref = Database.database().reference().child("users").child(userID!)
        ref?.observeSingleEvent(of: .value, with: { (snapshot) in
            let userDict = snapshot.value as! [String: Any]
            
            let userName = userDict["name"] as? String
            
            self.ref = Database.database().reference().child((self.post!.postCategory)).child((self.post!.postID))
            print(self.post?.postID)
            print(self.post?.postCategory)
            self.ref?.observeSingleEvent(of: .value, with: { (snapshot) in
                let postObject = snapshot.value as? [String: AnyObject]
                let postTitle  = postObject?["title"]
                let postDescription  = postObject?["description"]
                let postPrice = postObject?["price"]
                let postCategory = postObject?["category"]
                let postUserID = postObject?["userID"]
                let postID = postObject?["postID"]
                var postComments = postObject?["comments"] as! [String]
                
                let comment: String = "\(userName ?? ""): \(self.userInputComments.text!)"
                postComments.append(comment)
                
                let postData: [String: Any] = [
                    "title": postTitle!,
                    "description": postDescription!,
                    "price": postPrice!,
                    "category": postCategory!,
                    "userID": postUserID!,
                    "postID": postID!,
                    "comments": postComments
                ]
                self.ref.setValue(postData)
            })
        })
    }
    
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? CommentsTableViewController {
            destinationVC.currentPost = post
        }
    }
    

}
