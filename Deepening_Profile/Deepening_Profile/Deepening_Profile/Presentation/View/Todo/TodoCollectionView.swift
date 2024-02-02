//
//  TodoCollectionView.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/25/24.
//

import UIKit

class TodoCollectionView: UICollectionView {
    
    // MARK: - Properties
    
    var navigateToTodoDetail: ((TaskInfo) -> Void)?
    
    private var viewModel: TodoViewModel
    private lazy var data: [TaskInfo] = [] {
        didSet {
            reloadData()
        }
    }
    
    // MARK: - Life Cycle
    
    init(viewModel: TodoViewModel) {
        self.viewModel = viewModel
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getTodoData() {
        data = viewModel.readData()
    }
}

// MARK: - Extensions

extension TodoCollectionView {
    private func setupCollectionView() {
        self.backgroundColor = .white
        
        self.register(TodoCollectionViewCell.self, forCellWithReuseIdentifier: TodoCollectionViewCell.identifier)
        self.dataSource = self
        self.delegate = self
    }
}

extension TodoCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodoCollectionViewCell.identifier, for: indexPath) as? TodoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = data[indexPath.row]
        
        cell.delegate = self
        
        cell.title.text = item.title
        cell.createDate.text = String(describing: viewModel.dateFormat(item.createDate))
        cell.categoryLabel.text = item.category
        
        if item.isCompleted {
            cell.checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            cell.checkButton.tintColor = .systemGreen
        } else {
            cell.checkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            cell.checkButton.tintColor = .systemGray2
        }
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - 10) / 2
        let cellHeight = cellWidth * 3/4
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// MARK: UICollectionViewDelegate

extension TodoCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = data[indexPath.row]
        navigateToTodoDetail?(selectedItem)
    }
}

// MARK: TodoCellDelegate

extension TodoCollectionView: TodoCellDelegate {
    func todoCellDidTapCheckButton(_ cell: TodoCollectionViewCell) {
        guard let indexPath = indexPath(for: cell) else {
            return
        }

        let selectedItem = data[indexPath.row]
        
        viewModel.updateData(selectedItem.id, isCompleted: !selectedItem.isCompleted)
        getTodoData()
    }
}
