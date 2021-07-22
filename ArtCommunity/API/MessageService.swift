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
    
    static func fetchMessages(forUser user: User, completion: @escaping([Message]) -> Void) {
        var messages = [Message]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = COL_MESSAGES.document(uid).collection(user.uid).order(by: "timestamp")
        
        // addSnapshotListener - 데이터베이스에 추가될 때마다 가져올 수 있다
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let dictionary = change.document.data()
                    messages.append(Message(dictionary: dictionary))
                    completion(messages)
                }
            })
        }
    }
}
