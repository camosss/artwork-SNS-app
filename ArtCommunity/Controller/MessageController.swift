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
    private var conversations = [Conversation]()
    
    // 해당 유저에 메시지를 보낼때, 새로운 테이블 뷰가 띄워지는 걸 방지하기 위해
    // 새 Conversation을 추가할 때마다 이 키가 이미 존재한다고 표시
    private var convarsationsDictionary = [String: Conversation]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchConversations()
    }
    
    // MARK: - API
    
    func fetchConversations() {
        MessageService.fetechConversations { conversations in
            
            conversations.forEach { conversation in
                let message = conversation.message
                self.convarsationsDictionary[message.chatPartnerId] = conversation
            }
            
            self.conversations = Array(self.convarsationsDictionary.values)
            self.tableView.reloadData()
        }
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
        controller.delegate = self
        
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension MessageController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        
        cell.conversation = conversations[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MessageController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = conversations[indexPath.row].user
        let chat = ChatController(user: user)
        navigationController?.pushViewController(chat, animated: true)
    }
}

// MARK: - NewMessageControllerDelegate

extension MessageController: NewMessageControllerDelegate {
    func controller(_ controler: NewMessageController, startsChatWith user: User) {
        dismiss(animated: true, completion: nil) // searchController만 dismiss
        let chat = ChatController(user: user)
        navigationController?.pushViewController(chat, animated: true)
    }
}
