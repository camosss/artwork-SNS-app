//
//  ProfileViewModel.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/30.
//

import UIKit

struct ProfileHeaderViewModel {
    
    private let user: User
    
    let majorText: String
    
    var followersString: NSAttributedString? {
        return attributedText(withValue: 0, text: "followers")
    }
    
    var followingString: NSAttributedString? {
        return attributedText(withValue: 3, text: "following")
    }
    
    var ButtonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        } else {
            return "follow"
        }
    }
    
    init(user: User) {
        self.user = user
        self.majorText = "@ " + user.major
    }
    
    fileprivate func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)",
                                                        attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedTitle.append(NSAttributedString(string: " \(text)",
                                        attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                     .foregroundColor: UIColor.lightGray]))
        return attributedTitle
    }
}