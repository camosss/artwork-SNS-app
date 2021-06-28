//
//  MainTapController.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/22.
//

import UIKit
import Firebase

class MainTapController: UITabBarController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            
            feed.user = user
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        checkIfUserIsLoggedIn()
//        logout()
    }
    
    // MARK: - API
    
    func fetchUser() {
        UserService.fetchUser { userInfo in
            print("DEBUG: user is \(userInfo.name)")
            self.user = userInfo
        }
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            // DispatchQueue - 현재 사용자가 로그인되어있는지 확인하고, 일종의 API호출을 포함하기 때문에
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureViewController()
            fetchUser()
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Failed logout \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - Helpers
    
    func configureViewController() {
        view.backgroundColor = .white
                
        let feed = templateNavigationController(image: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController())
        let selector = templateNavigationController(image: #imageLiteral(resourceName: "plus_unselected"), rootViewController: SelectorController())
        let community = templateNavigationController(image: #imageLiteral(resourceName: "ribbon"), rootViewController: CommunityController())
        
        viewControllers = [feed, selector, community]
    }
    
    func templateNavigationController(image: UIImage, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.tintColor = .black
        return nav
    }
}

