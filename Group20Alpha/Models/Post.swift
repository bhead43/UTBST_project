//
//  Post.swift
//  Group20Alpha
//
//  Created by Brandon Head on 4/25/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

//Model for posts to follow. Should be super handy for database stuff if I make this right!

import UIKit
import Firebase //I *think* that I need Firebase stuff here. Emphasis on think.

class Post: NSObject {
    //General database nonsense
    var ref: DatabaseReference!
    

    public var postTitle: String
    public var postDescription: String
    public var postPrice: String    //We don't need to do any calculations with this, so it seems simpler to just leave this as a string rather than bother with casting it back and forth from int to string
    public var postCategory: String //This should work? As long as the branches in the database have the same names as string, shit shouldn't implode here
    public var postUser: String? //I think I can use some Firebase magic to grab this really easily?
    public var postID: String   //Saving this to the posts as well now to facilitate accessing the real stuff in the database more easily
    public var postComments: [String]
    
    init(title: String, description: String, price: String, category: String, userID: String, id: String, comments: [String]){
        ref = Database.database().reference()
        
        postTitle = title
        postDescription = description
        postPrice = price
        postCategory = category
        postUser = userID
        postID = id
        postComments = comments
        
        //Don't actually need to do this stuff here. No point in making a post just to unmake it immediately
//        //And here's the fun part. Upon initialization, we add this post to the appropiate branch of the database based on its category. Fingers crossed!
//        //Create the actual database, er, data for Firebase to read
//        let postData: [String: Any] = [
//            "title": postTitle,
//            "description": postDescription,
//            "price": postPrice,
//            "category": postCategory,
//            "userID": postUser
//        ]
//        //Push to the database
//        self.ref.child(postCategory).childByAutoId().setValue(postData)
    }
}
