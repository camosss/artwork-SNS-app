//
//  FeedController.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/22.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "FeedCell"
private let followingReuseIdentifier = "FeedFollowingCell"
private let headerIdentifier = "FeedHeader"

class FeedController: UICollectionViewController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet { configureLeftButton() }
    }
    
    private var selectedFilter: FeedFilterOptions = .Home {
        didSet { collectionView.reloadData() }
    }
    
    private var posts = [Post]()
    private var followingPosts = [Post]()
    
    private var currentDataSource: [Post] {
        switch selectedFilter {
        case .Home: return posts
        case .Following: return followingPosts
        }
    }
    
    var post: Post? {
        didSet { collectionView.reloadData() }
    }
    
    // MARK: - Lifecycle
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLeftButton()
        fetchPosts()
        fetchFollowingPosts()
    }
    
    // MARK: - API
    
    func fetchPosts() {
        PostService.fetchPosts { posts in
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    func fetchFollowingPosts() {
        PostService.fetchFeedPost { posts in
            self.followingPosts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
        
        let notificationButton = UIBarButtonItem(image: UIImage(systemName: "bell")!, style: .plain, target: self, action: #selector(GoToNotification))
        let messageButton = UIBarButtonItem(image:  UIImage(systemName: "paperplane")!, style: .plain, target: self, action: #selector(GoMessage))
        
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.rightBarButtonItems = [messageButton, notificationButton]
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(FeedFollowingCell.self, forCellWithReuseIdentifier: followingReuseIdentifier)
        collectionView.register(FeedHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        // 새로고침
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
    
    func configureLeftButton() {
        guard let user = user else { return }

        let profileImageView = UIImageView()
        profileImageView.setDimensions(width: 35, height: 35)
        profileImageView.layer.cornerRadius = 35 / 2
        profileImageView.layer.masksToBounds = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(GoToProfile))
        profileImageView.addGestureRecognizer(tap)
        
        profileImageView.sd_setImage(with: URL(string: user.profileImageUrl))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
    // MARK: - Action
    
    @objc func handleRefresh() {
        posts.removeAll()
        fetchPosts()
        fetchFollowingPosts()
    }
    
    @objc func GoToNotification() {
        let controller = NotificationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func GoMessage() {
        let controller = MessageController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    @objc func GoToProfile() {
        guard let user = user else { return }
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentDataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        let followingCell = collectionView.dequeueReusableCell(withReuseIdentifier: followingReuseIdentifier, for: indexPath) as! FeedFollowingCell
        
        followingCell.delegate = self
        cell.viewModel = PostViewModel(post: currentDataSource[indexPath.row])
        followingCell.viewModel = PostViewModel(post: currentDataSource[indexPath.row])
        
        return selectedFilter == .Home ? cell : followingCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! FeedHeader
        
        header.delegate = self
        return header
    }
}

    // MARK: - UICollectionViewDelegate

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = PostController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.post = currentDataSource[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFloowlayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    
    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    // 위, 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return selectedFilter == .Home ? 15 : 70
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthHome = (view.frame.width - 30) / 2
        let widthFollowing = view.frame.width
        
        return selectedFilter == .Home ? CGSize(width: widthHome, height: widthHome) : CGSize(width: widthFollowing, height: widthFollowing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    
    // 헤더와 cell 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 20, left: 5, bottom: 50, right: 5)
    }
}

// MARK: - FeedHeaderDelegate

extension FeedController: FeedHeaderDelegate {
    func didSelect(filter: FeedFilterOptions) {
        self.selectedFilter = filter
    }
}

// MARK: - FeedFollowingCellDelegate

extension FeedController: FeedFollowingCellDelegate {
    func cell(_ cell: FeedFollowingCell, goProfile uid: String) {
        UserService.fetchUser(withUid: uid) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
