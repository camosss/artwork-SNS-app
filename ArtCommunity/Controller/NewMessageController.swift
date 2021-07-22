//
//  NewMessageController.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/22.
//

import UIKit

private let reuseIdentifier = "UserCell"

class NewMessageController: UITableViewController {
    
    // MARK: - Properties
    
    private var users = [User]() {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
    }
    
    // MARK: - API
    
    func fetchUsers() {
        UserService.fetchUsers { users in
            self.users = users
            print(users)
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.title = "새 메세지"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(Dismissal))
        
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
        
    }
    
    // MARK: - Action
    
    @objc func Dismissal() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        
        return cell
    }
}
