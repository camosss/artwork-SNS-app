//
//  NotificationService.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/26.
//

import Firebase

struct NotificationService {
    
    static func uploadNotification(toUid postOwnerUid: String, fromUser: User, type: NotificationType, post: Post? = nil) {
        
        // A가 B의 게시물에 댓글, 좋아요를 했을 때, B의 계정에 알림이 뜨도록
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard postOwnerUid != currentUid else { return }
        
        let docRef = COL_NOTIFICATIONS.document(postOwnerUid).collection("user-notifications").document()
        
        var data: [String: Any] = ["timestamp": Timestamp(date: Date()),
                                   "uid": fromUser.uid,
                                   "type": type.rawValue,
                                   "id": docRef.documentID,
                                   "userProfileImageUrl": fromUser.profileImageUrl,
                                   "username": fromUser.name]
        
        if let post = post {
            data["postId"] = post.postId
            data["postImageUrl"] = post.imageUrl
        }
        
        docRef.setData(data)
    }
    
    static func fetchNotification(completion: @escaping([Notification]) -> Void) {
        guard let postOwnerUid = Auth.auth().currentUser?.uid else { return }
        
        COL_NOTIFICATIONS.document(postOwnerUid).collection("user-notifications").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            let notifications = documents.map({ Notification(dictionary: $0.data()) })
            completion(notifications)
        }
    }
}
