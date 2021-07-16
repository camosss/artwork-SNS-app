//
//  CommentService.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/16.
//

import Firebase

struct CommentService {
    
    static func uploadComment(comment: String, postID: String, user: User, completion: @escaping(Error?) -> Void) {
        let data: [String: Any] = ["uid": user.uid,
                                   "comment": comment,
                                   "timestamp": Timestamp(date: Date()),
                                   "username": user.name,
                                   "profileImageUrl": user.profileImageUrl]
        
        COL_POSTS.document(postID).collection("comments").addDocument(data: data, completion: completion)
    }
}
