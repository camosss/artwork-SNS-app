//
//  ProfileViewModel.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/30.
//

import UIKit

struct ProfileHeaderViewModel {
    
    // MARK: - Properties
    
    private let user: User
    
    let majorText: String
    
    var followersString: NSAttributedString? {
        return attributedText(withValue: user.stats?.followers ?? 0, text: "followers")
    }
    
    var followingString: NSAttributedString? {
        return attributedText(withValue: user.stats?.following ?? 0, text: "following")
    }
    
    var ButtonTitle: String {
        if user.isCurrentUser {
            return "프로필 편집"
        }
        
        return user.isFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor {
        return user.isCurrentUser || !user.isCurrentUser && user.isFollowed ? .white : .black
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser || user.isFollowed ? .black : .white
    }
    
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        self.majorText = "@ " + user.major
    }
    
    // MARK: - Helpers
    
    fileprivate func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)",
                                                        attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedTitle.append(NSAttributedString(string: " \(text)",
                                        attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                     .foregroundColor: UIColor.lightGray]))
        return attributedTitle
    }
}
