//
//  User.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/28.
//

import Foundation
import Firebase

struct User {
    let profileImageUrl: String
    let name: String
    let major: String
    let email: String
    let password: String
    let uid: String
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.major = dictionary["major"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
