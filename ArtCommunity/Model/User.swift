//
//  User.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/28.
//

import Foundation
import Firebase

struct User {
    var profileImageUrl: String
    var name: String
    var major: String
    let email: String
    let password: String
    let uid: String
    var bio: String?
    
    // 팔로우, 팔로윙 수
    var stats: UserStats!
    
    var isFollowed = false
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.major = dictionary["major"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""

//        if let profileImageUrl = dictionary["profileImageUrl"] as? String {
//            guard let url = URL(string: profileImageUrl) else { return }
//            self.profileImageUrl = url
//        }
        
        if let bio = dictionary["bio"] as? String {
            self.bio = bio
        }
    }
}

struct UserStats {
    let followers: Int
    let following: Int
}
