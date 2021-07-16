//
//  PostViewModel.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/01.
//

import UIKit

struct PostViewModel {
    
    // MARK: - Properties
    
    var post: Post
    
    var imageUrl: URL? { return URL(string: post.imageUrl) }
    
    var userProfileImageUrl: URL? { return URL(string: post.ownerImageUrl) }

    var username: String { return post.ownerUsername }
    
    var caption: String { return post.caption }
    
    var contents: String { return post.contents }
    
    var commentString: NSAttributedString {
        let commentCount = post.commentStats?.comments ?? 0
//        print("DEBUG: viewmodel \(commentCount)")
        return attributedText(withValue: commentCount, text: "개 댓글 모두 보기")
    }
    
    var likes: Int { return post.likes }
    
    var likesLabelText: NSAttributedString {
        if post.likes >= 1000 && post.likes < 1000000 {
            return attributedText(withValue: post.likes / 1000, text: "K")
            
        } else if post.likes >= 1000000 {
            return attributedText(withValue: post.likes / 1000000, text: "M")
            
        } else {
            return attributedText(withValue: post.likes, text: "")
        }
    }
    
    var likeButtonTintColor: UIColor {
        return post.didLike ? .red : .black
    }
    
    var likeButtonImage: UIImage? {
        let imageName = post.didLike ? "like_selected" : "like_unselected"
        return UIImage(named: imageName)
    }
    
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth, .weekOfYear]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        return formatter.string(from: post.timestamp.dateValue(), to: Date())
    }
    
    
    // MARK: - Lifecycle
    
    init(post: Post) {
        self.post = post
    }
    
    func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)",
                                                        attributes: [.font: UIFont.systemFont(ofSize: 13)])
        
        attributedTitle.append(NSAttributedString(string: " \(text)",
                                                  attributes: [.font: UIFont.systemFont(ofSize: 13),
                                                               .foregroundColor: UIColor.black]))
        return attributedTitle
    }
}
