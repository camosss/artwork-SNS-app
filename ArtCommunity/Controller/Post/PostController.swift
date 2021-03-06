//
//  PostController.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/01.
//

import UIKit

private let reuseIdentifier = "PostCell"

class PostController: UICollectionViewController {
    
    // MARK: - Properties
       
    var post: Post? {
        didSet { self.collectionView.reloadData() }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        checkIfUserLikePost()
        fetchCommentStats()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
        
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - API
    
    func checkIfUserLikePost() {
        if let post = post {
            PostService.checkIfUserLikedPost(post: post) { didLike in
                self.post?.didLike = didLike
            }
        }
    }
   
    func fetchCommentStats() {
        if let post = post {
            CommentService.checkCommentsCount(post: post) { stats in
                self.post?.commentStats = stats
                self.collectionView.reloadData()
    //            print("DEBUG: comment count is \(stats)")
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension PostController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PostCell
        
        cell.delegate = self
        
        if let post = post {
            cell.viewModel = PostViewModel(post: post)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

// PostCell이 들어갈 크기
extension PostController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        let height = width + 270
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - PostCellDelegate

extension PostController: PostCellDelegate {
    func cell(_ cell: PostCell, goProfile uid: String) {
        UserService.fetchUser(withUid: uid) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func cell(_ cell: PostCell, didLike post: Post) {
        cell.viewModel?.post.didLike.toggle()
        
        guard let tab = tabBarController as? MainTapController else { return }
        guard let currentUser = tab.user else { return }

        if post.didLike {
            //print("DEBUG: Unlike post")
            
            PostService.unlikePost(post: post) { error in
                cell.likeButton.setImage(UIImage(systemName: "suit.heart")!, for: .normal)
                cell.likeButton.tintColor = .black
                cell.viewModel?.post.likes = post.likes - 1
            }
            
        } else {
            //print("DEBUG: Like post")
            
            PostService.likePost(post: post) { error in
                cell.likeButton.setImage(UIImage(systemName: "suit.heart")!, for: .normal)
                cell.tintColor = .red
                cell.viewModel?.post.likes = post.likes + 1
                
                NotificationService.uploadNotification(toUid: post.ownerUid, fromUser: currentUser,
                                                       type: .like, post: post)
            }
        }
    }
    
    func cell(_ cell: PostCell, showComment post: Post) {
        let controller = CommentController(post: post)
        navigationController?.pushViewController(controller, animated: true)
    }
}
