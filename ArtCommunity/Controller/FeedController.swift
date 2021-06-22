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
}
