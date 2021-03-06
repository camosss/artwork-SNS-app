//
//  Post.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/01.
//

import Firebase

struct Post {
    var caption: String
    var contents: String
    var likes: Int
    let imageUrl: String
    let ownerUid: String
    let timestamp: Timestamp
    let postId: String
    var ownerImageUrl: String
    let ownerUsername: String
    
    var didLike = false
    var commentStats: CommentStats!
    
    init(postId: String, dictionary: [String: Any]) {
        self.postId = postId
        self.caption = dictionary["caption"] as? String ?? ""
        self.contents = dictionary["contents"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.ownerImageUrl = dictionary["ownerImageUrl"] as? String ?? ""
        self.ownerUsername = dictionary["ownerUsername"] as? String ?? ""
    }
}

struct CommentStats {
    let comments: Int
}
