//
//  UserService.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/28.
//

import Firebase

struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COL_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        COL_USERS.getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            
            let users = snapshot.documents.map({ User(dictionary: $0.data()) })
            completion(users)
        }
    }
    
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
}
