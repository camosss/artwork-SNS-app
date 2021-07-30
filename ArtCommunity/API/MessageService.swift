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
            
            // setData - 정보를 덮어쓰거나(내용 업데이트) 그렇지 않은 모든 것을 지우게 된다
            COL_MESSAGES.document(uid).collection("recent-messages").document(user.uid).setData(data)
            
            COL_MESSAGES.document(user.uid).collection("recent-messages").document(uid).setData(data)
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
    
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
       
        COL_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetechConversations(completion: @escaping([Conversation]) -> Void) {
        var conversations = [Conversation]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = COL_MESSAGES.document(uid).collection("recent-messages").order(by: "timestamp")
        
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                let dictionary = change.document.data()
                let message = Message(dictionary: dictionary)
                
                self.fetchUser(withUid: message.chatPartnerId) { user in
                    let conversation = Conversation(user: user, message: message)
                    conversations.append(conversation)
                    
                    conversations.sort { conversation1, conversation2 in
                        return conversation1.message.timestamp.seconds < conversation2.message.timestamp.seconds
                    }
                    completion(conversations)
                }
            })
        }
    }
}
