//
//  EditProfileOptions.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/16.
//

import Foundation

enum EditProfileOptions: Int, CaseIterable {
    case name
    case major
    case bio
    
    var description: String {
        switch self {
        case .name: return "이름"
        case .major: return "전공"
        case .bio: return "소개"
        }
    }
}

struct EditProfileViewModel {
    
    private let user: User
    let option: EditProfileOptions
    
    var shouldHideTextField: Bool {
        return option == .bio
    }
    
    init(user: User, option: EditProfileOptions) {
        self.user = user
        self.option = option
    }
}
