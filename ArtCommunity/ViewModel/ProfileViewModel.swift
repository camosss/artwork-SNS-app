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
        let userFollowers = user.stats?.followers ?? 0
        
        if userFollowers >= 1000 && userFollowers < 1000000 {
            return attributedText(withValue: userFollowers / 1000, text: "K followers")
            
        } else if userFollowers >= 1000000 {
            return attributedText(withValue: userFollowers / 1000000, text: "M followers")
            
        } else {
            return attributedText(withValue: userFollowers, text: "followers")
        }
    }
    
    var followingString: NSAttributedString? {
        let userFollowing = user.stats?.following ?? 0
        
        if userFollowing >= 1000 && userFollowing < 1000000 {
            return attributedText(withValue: userFollowing / 1000, text: "K following")
            
        } else if userFollowing >= 1000000 {
            return attributedText(withValue: userFollowing / 1000000, text: "M following")
            
        } else {
            return attributedText(withValue: userFollowing, text: "following")
        }
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
