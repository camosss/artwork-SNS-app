//
//  FeedController.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/22.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet { configureLeftButton() }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLeftButton()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        let messageButton = UIBarButtonItem(image: #imageLiteral(resourceName: "send2"), style: .plain, target: self, action: #selector(GoToMessage))
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search_selected"), style: .plain, target: self, action: #selector(GoToSearch))

        navigationItem.rightBarButtonItems = [messageButton, searchButton]
    }
    
    func configureLeftButton() {
        guard let user = user else { return }

        let profileImageView = UIImageView()
        profileImageView.setDimensions(width: 35, height: 35)
        profileImageView.layer.cornerRadius = 35 / 2
        profileImageView.layer.masksToBounds = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(GoToProfile))
        profileImageView.addGestureRecognizer(tap)
        
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
    // MARK: - Action
    
    @objc func GoToSearch() {
        let controller = SearchController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func GoToMessage() {
        let controller = MessageController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func GoToProfile() {
//        let profileLayout = UICollectionViewFlowLayout()
        guard let user = user else { return }
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}
