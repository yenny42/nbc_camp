//
//  PlayerViewController.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/29/24.
//

import UIKit
import AVKit

class PlayerViewController: UIViewController {
    
    // MARK: - Properties
    
    var data: [Video] = []
    
    let playerController = AVPlayerViewController()
    lazy var url: URL = URL(string: "")!
    lazy var player = AVPlayer(url: self.url as URL)
    
    // MARK: - UI Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.rowHeight = 100
        
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        setDelegate()
        setUI()
        setLayout()
    }
}

// MARK: - Extensions : UI & Layout Setting

extension PlayerViewController {
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setData() {
        PlayerViewModel.randomVideo { result in
            switch result {
                case .success(let video):
                    self.data = video
                case .failure(let error):
                    print("Error decoding RandomDog: \(error)")
            }
        }
    }
}

// MARK: - Extensions : UITableView Delegate & DataSource

extension PlayerViewController: UITableViewDelegate, UITableViewDataSource {
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: PlayerTableViewCell.identifier)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.identifier, for: indexPath) as! PlayerTableViewCell
        cell.selectionStyle = .none
        
        let item = data[indexPath.row]
        
        cell.title.text = "\(item.title)"
        ImageLoader.loadImage(from: item.thumbnailUrl, into: cell.thumbnail)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.url = URL(string: data[indexPath.row].videoUrl)!
        self.player = AVPlayer(url: self.url as URL)
        
        playerController.player = self.player
        
        present(playerController, animated: true) {
            self.player.play()
        }
    }
}
