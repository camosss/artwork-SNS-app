//
//  ChatViewModel.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/22.
//

import UIKit

struct ChatViewModel {
    
    private let message: Message
    
    var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ? .systemTeal : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .white : .black
    }
    
    // 로그인한 사용자면 오른쪽, 아니면 왼쪽
    var rightActive: Bool {
        return message.isFromCurrentUser
    }
    
    var leftActive: Bool {
        return !message.isFromCurrentUser
    }
    
    // 로그인한 사용자면 프로필 이미지를 없애기
    var shouldHideProfileImage: Bool {
        return message.isFromCurrentUser
    }
    
    var profileImageUrl: URL? {
        guard let user = message.user else { return nil }
        return URL(string: user.profileImageUrl)
    }
    
    init(message: Message) {
        self.message = message
    }
}
