//
//  PostService.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/30.
//

import UIKit
import Firebase

struct PostService {
    static func uploadPost(caption: String, image: UIImage, completion: @escaping(Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageUrl": imageUrl,
            "ownerUid": uid] as [String: Any]
            
            COL_POSTS.addDocument(data: data, completion: completion)
        }
    }
}
