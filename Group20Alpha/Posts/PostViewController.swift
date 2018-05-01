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
    
    //receives the data from Post variable from SubCategory table with values for
    //title, description, price, category, userID & comments as strings
    var post: Post?
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    //@IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentsTextView: UITextView!
    
    
    @IBAction func showCommentsButtonClick(_ sender: Any) {
        
        
        
        if post?.postComments.count == 0 {
            let alertController = UIAlertController(title: "Alert", message: "There are no comments for this post yet.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        
        if ((post?.postComments.count)! <= 1){
             let alertController = UIAlertController(title: "Alert", message: "There are still no comments for this post yet.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
            present(alertController, animated: true, completion: nil)
            return
        }
    }
        
    }
    
    //Here's some stuff to make keyboards work (hopefully)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 'First Responder' is the same as 'input focus'.
        // We are removing input focus from the text field.
        textField.resignFirstResponder()
        return true
    }
    
    //STILL NOT MY CODE
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // This causes the keyboard to be dismissed.
        self.view.endEditing(true)
    }
    
    
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
        let alertController = UIAlertController(title: "Comment Recorded", message: "Your comment has been recorded.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    

    @IBAction func clearCommentButton(_ sender: Any) {
        clearCommentSection()
    }
    func clearCommentSection() {
        commentsTextView.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = post!.postTitle
        descriptLabel.text = post!.postDescription
        priceLabel.text = post!.postPrice
        
        imageView.image = post!.postImage

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
