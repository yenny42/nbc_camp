//
//  ViewController.swift
//  WishLIst_Skilled
//
//  Created by t2023-m0035 on 1/4/24.
//

import UIKit
import CoreData

class ProductVC: UIViewController {
    
    weak var delegate: WishListViewDelegate?
    
    // MARK: - Properties
    
    var productData: Product?
    var wishListData: [WishList]? = []
    
    // MARK: - UI Properties
    
    private lazy var stackView: UIStackView = { createStackView() }()
    
    private let wishListVC = WishListVC()
    private let productView = ProductView()
    private let productButtonView = ProductButtonView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchInitialData()
        setDelegate()
        setUI()
        setLayout()
    }
    
    // MARK: - Fetch Data
    
    func fetchInitialData() {
        // 뒤에 있는 클로저 = completion
        // - 비동기 작업이 끝난 후에 호출되는 완료 핸들러
        
        // result
        // = 완료 핸들러 클로저의 인자
        // Result<Product, Error> 형태의 값
        
        // static func decodeProduct은 특정 인스턴스에 의존하지 않고 해당 타입 자체에 속하는 정적 메서드
        // 정적 메서드는 특정 인스턴스에 대한 참조를 가지지 않음
        // = 메모리 누수와 관련된 문제가 발생하지 않음
        // = [weak self] 를 사용하지 않아도 됨
        
        // [weak self]
        // - 해당 클로저가 self를 강한 참조로 캡처하지 않도록 하기 위한 표현
        ProductRequests.decodeProduct { result in
            
            // 네트워크 요청에서 받은 결과를 메인 스레드에서 처리하기 위해 사용
            // - 네트워크 요청은 백그라운드 스레드에서 이루어짐
            // - UI 업데이트와 관련된 작업은 메인 스레드에서 해야 함
            // = DispatchQueue.main.async를 사용하여 메인 스레드에서 UI 업데이트 코드를 실행
            
            DispatchQueue.main.async {
                
                // 메인 스레드에서 UI 업데이트 작업 (1)
                self.productView.hideSkeletonView()
                
                // Result 열거형을 사용한 애러 처리 분기
                switch result {
                    // 비동기 작업 성공
                    // = Product 타입으로 전달된 값을 product 상수에 담아서 사용
                    case .success(let product):
                        // 메인 스레드에서 UI 업데이트 작업 (2)
                    self.productView.updateUIWithProduct(product)
                    self.productData = product
                    
                    // 비동기 작업 실패
                    // = 디코딩 실패한 경우 출력되는 에러
                    case .failure(let error):
                        print("Error decoding product: \(error)")
                }
            }
        }
    }
}

//MARK: - Delegate

extension ProductVC: ProductViewDelegate {
    
    // MARK: ProductView Delegate Method
    
    func didTapAddWishListButton() {
        actionAlert(in: self, title: "위시리스트 담기", message: "해당 상품을 추가하시겠습니까?") {
            self.saveData(self.productData!)
            actionAlert(in: self, title: "추가되었습니다.", message: "", cancelButton: false)
        }
    }
    
    func didTapShowAnotherProduct() {
        fetchInitialData()
    }
    
    func didTapShowWishList() {
        readData()
        delegate?.getWishListData(self.wishListData!)
        self.present(wishListVC, animated: true)
    }

    // MARK: Core Data Method
    
    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    // Data Create
    func saveData(_ wish: Product) {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let newWish = WishList(context: context)
        
        newWish.id = UUID()
        newWish.productId = Int64(wish.id)
        newWish.name = wish.title
        newWish.desc = wish.description
        newWish.price = Int64(wish.price)
        newWish.brand = wish.brand
        newWish.thumbnail = wish.thumbnail
        
        try? context.save()
    }
    
    // Data Read
    func readData() {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let request = WishList.fetchRequest()
        let wishList = try? context.fetch(request)
        
        self.wishListData = wishList
    }
    
    // Data All Delete
    func deleteAllData() {
        guard let context = self.persistentContainer?.viewContext else { return }

        let request = WishList.fetchRequest()

        guard let allWishList = try? context.fetch(request) else { return }

        for wish in allWishList {
            context.delete(wish)
        }

        try? context.save()
    }
}

// MARK: - Extensions

extension ProductVC {
    private func setUI() {
        view.backgroundColor = .white
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        productView.translatesAutoresizingMaskIntoConstraints = false
        productButtonView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setLayout() {
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
        
        productView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.75).isActive = true
        productButtonView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.25).isActive = true
    }
    
    private func setDelegate() {
        self.delegate = wishListVC
        productButtonView.delegate = self
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        [productView, productButtonView].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }
}
