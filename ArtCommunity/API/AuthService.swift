//
//  AuthService.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/27.
//

import UIKit
import Firebase

struct AuthCredentials {
    let profileImage: UIImage
    let name: String
    let major: String
    let email: String
    let password: String
}

struct AuthService {
    
    static func logUser(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUser(withCredential credentials: AuthCredentials, completion: @escaping(Error?) -> Void) {
        
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error {
                    print("DEBUG: AuthService - \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                let data: [String: Any] = ["name": credentials.name,
                                           "major": credentials.major,
                                           "email": credentials.email,
                                           "profileImage": imageUrl,
                                           "uid": uid]
                
                Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
            }
        }
    }
}
