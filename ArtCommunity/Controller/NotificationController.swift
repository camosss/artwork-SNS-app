
//  NotificationController.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/22.
//

import UIKit

private let reuserIdentifier = "NofiticationCell"

class NotificationController: UITableViewController {
    
    // MARK: - Properties
    
    private let refresher = UIRefreshControl()
        
    private var notifications = [Notification]() {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchNotifications()
    }
    
    // MARK: - API
    
    func fetchNotifications() {
        NotificationService.fetchNotification { notifications in
            self.notifications = notifications
            self.checkIfUserIsFollowed()
        }
    }
    
    func checkIfUserIsFollowed() {
        notifications.forEach { notification in
            guard notification.type == .follow else { return }
            
            UserService.checkIfUserIsFollowed(uid: notification.uid) { isFollowed in
                if let index = self.notifications.firstIndex(where: { $0.id == notification.id }) {
                    self.notifications[index].userIsFollowed = isFollowed
                }
            }
        }

    }
    
    // MARK: - Action
    
    @objc func handleRefresh() {
        notifications.removeAll()
        fetchNotifications()
        refresher.endRefreshing()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "알림"
        
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuserIdentifier)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refresher
    }
}

// MARK: - UITableViewDataSource

extension NotificationController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuserIdentifier, for: indexPath) as! NotificationCell
        
        cell.viewModel = NotificationViewModel(notification: notifications[indexPath.row])
        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate

extension NotificationController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        UserService.fetchUser(withUid: notifications[indexPath.row].uid) { user in
            // 팔로우 알림일 때만, 사용자 프로필로 이동
            if self.notifications[indexPath.row].type == .follow {
                let controller = ProfileController(user: user)
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
        
        guard let postId = notifications[indexPath.row].postId else { return }
        
        if self.notifications[indexPath.row].type == .comment {
            
            PostService.fetchPost(withPostId: postId) { post in
                let controller = CommentController(post: post)
                self.navigationController?.pushViewController(controller, animated: true)
            }
        } else if self.notifications[indexPath.row].type == .like {
            
            PostService.fetchPost(withPostId: postId) { post in
                let controller = PostController(collectionViewLayout: UICollectionViewFlowLayout())
                controller.post = post
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
}

// MARK: - NotificationCellDelgate

extension NotificationController: NotificationCellDelgate {

    func cell(_ cell: NotificationCell, wantsToFollow uid: String) {
        UserService.follow(uid: uid) { _ in
            cell.viewModel?.notification.userIsFollowed.toggle()
        }
    }
    
    func cell(_ cell: NotificationCell, wantsToUnFollow uid: String) {
        UserService.unfollow(uid: uid) { _ in
            cell.viewModel?.notification.userIsFollowed.toggle()
        }
    }
    
    func cell(_ cell: NotificationCell, wantsToViewPost postId: String) {
        PostService.fetchPost(withPostId: postId) { post in
            let controller = PostController(collectionViewLayout: UICollectionViewFlowLayout())
            controller.post = post
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func cell(_ cell: NotificationCell, goToProfile user: User) {        
        let controller = ProfileController(user: user)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
