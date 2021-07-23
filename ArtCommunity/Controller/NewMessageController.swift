//
//  NewMessageController.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/22.
//

import UIKit

private let reuseIdentifier = "UserCell"

protocol NewMessageControllerDelegate: AnyObject {
    func controller(_ controler: NewMessageController, startsChatWith user: User)
}

class NewMessageController: UITableViewController {
    
    // MARK: - Properties
    
    weak var delegate: NewMessageControllerDelegate?
    
    private var users = [User]() {
        didSet { tableView.reloadData() }
    }
    
    private var filterUsers = [User]() {
        didSet { tableView.reloadData() }
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
        configureSearchBar()
    }
    
    // MARK: - API
    
    func fetchUsers() {
        UserService.fetchUsers { users in
            self.users = users
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
    
    // search bar
    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false // searchbar 클릭 시 어두워짐
        searchController.hidesNavigationBarDuringPresentation = true // navigation title 없어짐
        searchController.searchBar.placeholder = "검색"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
    
    // MARK: - Action
    
    @objc func Dismissal() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filterUsers.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        
        let user = inSearchMode ? filterUsers[indexPath.row] : users[indexPath.row]
        cell.user = user
        return cell
    }
}

// MARK: - UITableViewDelegate

extension NewMessageController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchMode ? filterUsers[indexPath.row] : users[indexPath.row]
        delegate?.controller(self, startsChatWith: user)
    }
}

// MARK: - UISearchResultsUpdating

extension NewMessageController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        filterUsers = users.filter({ $0.name.lowercased().contains(searchText) || $0.major.contains(searchText) })
    }
}
