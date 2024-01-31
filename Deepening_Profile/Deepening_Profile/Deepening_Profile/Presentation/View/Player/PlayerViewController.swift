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
    
    var data: [Video] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let playerController = AVPlayerViewController()
    var url: URL?
    lazy var player: AVPlayer = {
        AVPlayer(url: self.url!)
    }()
    
    // MARK: - UI Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setDelegate()
        setUI()
    }
}

// MARK: - Extensions : UI & Layout Setting

extension PlayerViewController {
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        setLayout()
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func fetchData() {
        if self.data.isEmpty {
            PlayerVideoAPI.getVideo { result in
                switch result {
                case .success(let video):
                    self.data = video
                case .failure(let error):
                    print("Error decoding video: \(error)")
                }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.identifier, for: indexPath) as! PlayerTableViewCell
        cell.selectionStyle = .none

        let item = data[indexPath.row]
        
        cell.title.text = "\(item.title)"
        
        cell.tag = indexPath.row
        cell.loadImage(from: item.thumbnailUrl)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        url = URL(string: data[indexPath.row].videoUrl)
        if let url = url {
            navigateToAVPlayerVC(url)
        } else {
            print("The video URL is not valid.")
        }
    }

    private func navigateToAVPlayerVC(_ url: URL) {
        player.replaceCurrentItem(with: AVPlayerItem(url: url))

        playerController.player = player

        present(playerController, animated: true) {
            self.player.play()
        }
    }
}
