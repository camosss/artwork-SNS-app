//
//  ImageUploader.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/27.
//

import FirebaseStorage

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        
        // 1. 이미지를 JPEG 데이터로 변환
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = NSUUID().uuidString
        // Firebase "Storage"에 저장
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        // 2. 이미지 데이터를 업로드
        ref.putData(imageData, metadata: nil) { metaData, error in
            if let error = error {
                print("DEBUG: ImageUploader - \(error.localizedDescription)")
                return
            }
            // 3. 하위 값을 업데이트하고 프로필 이미지 URL을 사용하여 completion
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
}
