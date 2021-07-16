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
    
    var titleText: String { return option.description }
    
    var optionValue: String? {
        switch option {
        case .name: return user.name
        case .major: return user.major
        case .bio: return user.bio
        }
    }
    
    // bio일 때, 텍스트필드를 숨기고, view를 띄운다.
    var shouldHideTextField: Bool { return option == .bio }
    
    var shouldHideTextView: Bool { return option != nil }
    
    var shouldHidePlacholderLabel: Bool { return user.bio != nil }

    
    init(user: User, option: EditProfileOptions) {
        self.user = user
        self.option = option
    }
}
