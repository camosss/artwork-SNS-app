//
//  PostService.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/30.
//

import UIKit
import Firebase

struct PostService {
    static func uploadPost(caption: String, contents: String, image: UIImage, user: User, completion: @escaping(Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data = ["caption": caption,
                        "contents": contents,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageUrl": imageUrl,
                        "ownerUid": uid,
                        "ownerImageUrl": user.profileImageUrl,
                        "ownerUsername": user.name] as [String: Any]
            
            let docRef = COL_POSTS.addDocument(data: data, completion: completion)
            
            self.updateUserFeedAfterPost(postId: docRef.documentID)
        }
    }
    
    static func fetchPosts(completion: @escaping([Post]) -> Void) {
        COL_POSTS.order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            let posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            completion(posts)
        }
    }
    
    // 모든 post를 uid에 전달
    static func fetchPosts(forUser uid: String, completion: @escaping([Post]) -> Void) {
        let query = COL_POSTS.whereField("ownerUid", isEqualTo: uid)
        
        query.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            var posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            
            // 순서대로 정렬
            posts.sort { (post1, post2) -> Bool in
                return post1.timestamp.seconds > post2.timestamp.seconds
            }
            completion(posts)
        }
    }
    
    static func fetchPost(withPostId postId: String, completion: @escaping(Post) -> Void) {
        COL_POSTS.document(postId).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }
            guard let data = snapshot.data() else { return }
            
            let post = Post(postId: postId, dictionary: data)
            completion(post)
        }
    }
    
    // MARK: - Like, UnLike
    
    static func likePost(post: Post, completion: @escaping(Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COL_POSTS.document(post.postId).updateData(["likes" : post.likes + 1])
        
        // setData[:} -> 사용자 uid까지만 정보를 나타내면 되기 때문에 빈문서로
        COL_POSTS.document(post.postId).collection("post-likes").document(uid).setData([:]) { _ in
            COL_USERS.document(uid).collection("user-likes").document(post.postId).setData([:], completion: completion)
        }
    }
    
    static func unlikePost(post: Post, completion: @escaping(Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COL_POSTS.document(post.postId).updateData(["likes" : post.likes - 1])
        
        COL_POSTS.document(post.postId).collection("post-likes").document(uid).delete() { _ in
            COL_USERS.document(uid).collection("user-likes").document(post.postId).delete(completion: completion)
        }
    }
    
    static func checkIfUserLikedPost(post: Post, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        COL_USERS.document(uid).collection("user-likes").document(post.postId).getDocument { (snapshot, _) in
            guard let didLike = snapshot?.exists else { return }
            completion(didLike)
        }
    }
    
    // MARK: - Fetching Following User Post
    
    static func updateUserFeedAfterFollowing(user: User, didFollow: Bool) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = COL_POSTS.whereField("ownerUid", isEqualTo: user.uid)
        query.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            let docIDs = documents.map({ $0.documentID })
            docIDs.forEach { id in
                if didFollow {
                    COL_USERS.document(uid).collection("following-user-posts").document(id).setData([:])
                } else {
                    COL_USERS.document(uid).collection("following-user-posts").document(id).delete()
                }
            }
        }
    }
    
    static func fetchFeedPost(completion: @escaping([Post]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var posts = [Post]()

        COL_USERS.document(uid).collection("following-user-posts").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                fetchPost(withPostId: document.documentID) { post in
                    posts.append(post)
                    
                    posts.sort { (post1, post2) -> Bool in
                        return post1.timestamp.seconds > post2.timestamp.seconds
                    }
                    
                    completion(posts)
                }
            })
        }
    }
    
    // 팔로우한 사용자가 새 게시물을 업로드하면, following-user-posts에도 추가
    static func updateUserFeedAfterPost(postId: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COL_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            documents.forEach { document in
                COL_USERS.document(document.documentID).collection("following-user-posts").document(postId).setData([:])
            }
        }
    }
}
