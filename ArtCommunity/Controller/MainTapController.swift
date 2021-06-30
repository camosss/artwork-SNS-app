//
//  MainTapController.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/22.
//

import UIKit
import Firebase
import YPImagePicker

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
        UserService.fetchUser() { user in
            self.user = user
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
        self.delegate = self
                
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
    
    func didFinishPickingMedia(_ picker: YPImagePicker) {
        picker.didFinishPicking { items,_ in
            picker.dismiss(animated: true) {
                guard let selectedImage = items.singlePhoto?.image else { return }
                print("DEBUG: Selected image is \(selectedImage)")
            }
        }
    }
}

// MARK: - UITabBarControllerDelegate

extension MainTapController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.firstIndex(of: viewController)
        
        if index == 1 {
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = false
            config.startOnScreen = .library
            config.screens = [.library]
            config.hidesStatusBar = false
            config.library.maxNumberOfItems = 1
            
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
            
            didFinishPickingMedia(picker)
        }
        return true
    }
}
