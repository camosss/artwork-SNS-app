//
//  FeedController.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/22.
//

import UIKit

class FeedController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        let messageButton = UIBarButtonItem(image: #imageLiteral(resourceName: "send2"), style: .plain, target: self, action: #selector(GoToMessage))
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search_selected"), style: .plain, target: self, action: #selector(GoToSearch))

        navigationItem.rightBarButtonItems = [messageButton, searchButton]
        
        let profileImageButton = UIButton()
        profileImageButton.backgroundColor = .lightGray
        profileImageButton.setDimensions(width: 32, height: 32)
        profileImageButton.layer.cornerRadius = 32 / 2
        profileImageButton.layer.masksToBounds = true
        profileImageButton.addTarget(self, action: #selector(GoToProfile), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageButton)
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
        let controller = ProfileController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
