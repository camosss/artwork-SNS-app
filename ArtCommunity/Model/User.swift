//
//  User.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/28.
//

import Foundation

struct User {
    let profileImageUrl: String
    let name: String
    let major: String
    let email: String
    let password: String
    let uid: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.profileImageUrl = dictionary["profileImage"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.major = dictionary["major"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
