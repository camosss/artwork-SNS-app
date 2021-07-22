//
//  MessageService.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/22.
//

import UIKit
import Firebase

struct MessageService {
    static func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["text": message,
                    "fromId": uid,
                    "toId": user.uid,
                    "timestamp": Timestamp(date: Date())] as [String: Any]
        
        COL_MESSAGES.document(uid).collection(user.uid).addDocument(data: data) { _ in
            COL_MESSAGES.document(user.uid).collection(uid).addDocument(data: data, completion: completion)
        }
    }
}
