//
//  NotificationViewModel.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/26.
//

import UIKit

struct NotificationViewModel {
    
    private let notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
    }
    
    var postImageUrl: URL? { return URL(string: notification.postImageUrl ?? "") }
    
    var profileImageUrl: URL? { return URL(string: notification.userProfileImageUrl) }
    
    var shouldHidePostImage: Bool { return notification.type == .follow }
    
    
    var notificationMessage: NSAttributedString {
        let username = notification.username
        
        let message = notification.type.notificationMessage
        
        let attributedText = NSMutableAttributedString(string: username, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: message, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSAttributedString(string: "  2m", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        return attributedText
    }
    
}
