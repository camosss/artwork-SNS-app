//
//  UserService.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/28.
//

import Firebase

struct UserService {
        
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
       
        COL_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        COL_USERS.getDocuments { snapshot, error in
            
            guard var users = snapshot?.documents.map({ User(dictionary: $0.data()) }) else { return }
            
            // 현재 사용자는 목록에서 제거
            if let currentUser = users.firstIndex(where: { $0.uid == Auth.auth().currentUser?.uid }) {
                users.remove(at: currentUser)
            }
            
            completion(users)
        }
    }
    
    // MARK: - Follow, UnFollow
    
    // currentUid = 로그인되있는 사용자, uid = 팔로우한 사용자
    static func follow(uid: String, completion: @escaping(Error?) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COL_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { error in
            COL_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
        }
    }
    
    static func unfollow(uid: String, completion: @escaping(Error?) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COL_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { error in
            COL_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
    }
    
    // 팔로우 체크
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COL_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { snapshot, error in
            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
    }
    
    // 팔로우, 팔로윙 수 파악
    static func fetchUserStats(uid: String, completion: @escaping(UserStats) -> Void) {
        COL_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, _ in
            let followers = snapshot?.documents.count ?? 0
            
            COL_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, _ in
                let following = snapshot?.documents.count ?? 0
                
                completion(UserStats(followers: followers, following: following))
            }
        }
    }
    
    // MARK: - Update User name
    
    static func saveUserData(user: User, completion: @escaping(Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let values = ["name": user.name,
                      "major": user.major,
                      "bio": user.bio ?? ""]

        COL_USERS.document(uid).updateData(values, completion: completion)
        
        // 게시물 유저 정보 업데이트
        let query = COL_POSTS.whereField("ownerUid", isEqualTo: uid)
        query.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            documents.forEach { document in
                let post = Post(postId: document.documentID, dictionary: document.data())
                COL_POSTS.document(post.postId).updateData(["ownerUsername": user.name])
            }
        }
        
    }


    // MARK: - Update User ProfileImage
    
    static func updateProfileImage(image: UIImage, completion: @escaping(URL?) -> Void) {

        guard let uid = Auth.auth().currentUser?.uid else { return }

        ImageUploader.uploadImage(image: image) { profileImageUrl in
            let value = ["profileImageUrl": profileImageUrl]

            COL_USERS.document(uid).updateData(value) { error in
                completion(URL(string: profileImageUrl))
            }
            
            // 게시물 유저 정보 업데이트
            COL_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { document in
                    let post = Post(postId: document.documentID, dictionary: document.data())
                    
                    fetchUser(withUid: uid) { user in
                        COL_POSTS.document(post.postId).updateData(["ownerImageUrl": user.profileImageUrl])
                    }
                }
            }
        }
    }
}

