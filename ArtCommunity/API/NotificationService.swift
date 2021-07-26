//
//  NotificationService.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/26.
//

import Firebase

struct NotificationService {
    
    static func uploadNotification(toUid postOwnerUid: String, type: NotificationType, post: Post? = nil) {
        
        // A가 B의 게시물에 댓글, 좋아요를 했을 때, B의 계정에 알림이 뜨도록
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard postOwnerUid != currentUid else { return }
        
        let docRef = COL_NOTIFICATIONS.document(postOwnerUid).collection("user-notifications").document()
        
        var data: [String: Any] = ["timestamp": Timestamp(date: Date()),
                                   "uid": currentUid,
                                   "type": type.rawValue,
                                   "id": docRef.documentID]
        
        if let post = post {
            data["postId"] = post.postId
            data["postImageUrl"] = post.imageUrl
        }
        
        docRef.setData(data)
    }
}
