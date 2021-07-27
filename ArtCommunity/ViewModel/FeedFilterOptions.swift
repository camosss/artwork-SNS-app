//
//  FeedFilterOptions.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/27.
//

import Foundation

// CaseIterable -> 모든 case 값들에 대한 컬렉션을 제공하는 타입
enum FeedFilterOptions: Int, CaseIterable {
    case Home
    case Following
    
    var description: String {
        switch self {
        case .Home: return "Home"
        case .Following: return "Following"
        }
    }
}
