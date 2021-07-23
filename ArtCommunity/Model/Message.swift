//
//  Message.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/22.
//

import Firebase

struct Message {
    let text: String
    let toId: String
    let fromId: String
    let timestamp: Timestamp!
    var user: User?
    
    let isFromCurrentUser: Bool
    
    // 메세지창에 메세지를 보낸 유저의 정보가 뜨도록
    var chatPartnerId: String { return isFromCurrentUser ? toId : fromId }
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        
        self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
    }
}

struct Conversation {
    let user: User
    let message: Message
}
