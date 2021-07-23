//
//  MessageViewModel.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/23.
//

import Foundation

struct MessageViewModel {
    
    private let conversation: Conversation
    
    var profileImageUrl: URL? {
        return URL(string: conversation.user.profileImageUrl)
    }
    
    var timestamp: String {
        let date = conversation.message.timestamp.dateValue()
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "hh:mm a"
        return dataFormatter.string(from: date)
    }
    
    init(conversation: Conversation) {
        self.conversation = conversation
    }
}
