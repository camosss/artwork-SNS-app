//
//  CommentViewModel.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/16.
//

import UIKit

struct CommentViewModel {
    
    var comment: Comment
    
    var profileImageUrl: URL? { return URL(string: comment.profileImageUrl) }
        
    var username: String { return comment.username }
    
    var commentText: String { return comment.commentText }
    
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth, .weekOfYear]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        return formatter.string(from: comment.timestamp.dateValue(), to: Date())
    }
    
    init(comment: Comment) { self.comment = comment }
}
