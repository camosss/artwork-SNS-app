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
    
    static func fetchComments(forPost postID: String, completion: @escaping([Comment]) -> Void) {
        
        var comments = [Comment]()
        
        let query = COL_POSTS.document(postID).collection("comments").order(by: "timestamp", descending: true)
        
        // - addSnapshotListener
        // 해당 comment를 수신한 다음 해당 comment를 기반으로 UI를 업데이트
        // API 호출을 수동으로 수행할 필요없이 데이터베이스에 추가되는 즉시
        // 새로운 comment가 데이터를 새로고침하기 위해 포스트하는 것과 같음
        
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let data = change.document.data()
                    let comment = Comment(dictionary: data)
                    comments.append(comment)
                }
            })
            
            completion(comments)
        }
    }
}
