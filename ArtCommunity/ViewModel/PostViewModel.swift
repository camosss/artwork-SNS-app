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
        
    var likes: Int { return post.likes }
    
    var likeButtonTintColor: UIColor {
        return post.didLike ? .red : .black
    }
    
    var likeButtonImage: UIImage? {
        let imageName = post.didLike ? "like_selected" : "like_unselected"
        return UIImage(named: imageName)
    }
    
    var likesLabelText: String { return "\(post.comments)명이 좋아합니다" }
    
    var comments: String { return "댓글 \(post.comments)개 모두 보기" }
    
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
}
