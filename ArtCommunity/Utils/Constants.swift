//
//  Constants.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/28.
//

import Firebase

let COL_USERS = Firestore.firestore().collection("users")
let COL_POSTS = Firestore.firestore().collection("posts")
let COL_FOLLOWERS = Firestore.firestore().collection("followers")
let COL_FOLLOWING = Firestore.firestore().collection("following")
let COL_MESSAGES = Firestore.firestore().collection("messages")
