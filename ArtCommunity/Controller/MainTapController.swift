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
    
    var user: User?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        checkIfUserIsLoggedIn()
//        logout()
        fetchUser()
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
                let controller = LoginController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
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
                
        let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController())
        let selector = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: SelectorController())
        let community = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "ribbon"), selectedImage: #imageLiteral(resourceName: "ribbon"), rootViewController: CommunityController())
        
        viewControllers = [feed, selector, community]
    }
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        return nav
    }
}
