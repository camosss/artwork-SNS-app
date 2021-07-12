//
//  PostViewModel.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/01.
//

import Foundation

struct PostViewModel {
    private let post: Post
    
    var imageUrl: URL? { return URL(string: post.imageUrl) }
    
    var userProfileImageUrl: URL? { return URL(string: post.ownerImageUrl) }

    var username: String { return post.ownerUsername }
    
    var caption: String { return post.caption }
    
    var contents: String { return post.contents }
    
    var likes: Int { return post.likes }
    
    init(post: Post) {
        self.post = post
    }
}
