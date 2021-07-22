//
//  MessageController.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/22.
//

import UIKit

private let reuseIdentifier = "MessageCell"

class MessageController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        configureTableView()
        
        // navigationBar와 view 경계 없애기
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.title = "메시지"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(searchUser))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_arrow_back_white_24dp"), style: .plain, target: self, action: #selector(Dismissal))
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        
        tableView.register(MessageCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    // MARK: - Action
    
    @objc func Dismissal() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func searchUser() {
        let controller = NewMessageController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension MessageController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = "11"
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MessageController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
