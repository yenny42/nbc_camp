//
//  ProfileViewModel.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/24/24.
//

import Foundation

protocol UserViewModel: AnyObject {
    func updateUserName(name: String)
    func updateUserAge(age: Int)
}

class ProfileViewModel {
    private var userProfile: ProfileInfo
    weak var delegate: UserViewModel?
    
    init(userProfile: ProfileInfo) {
        self.userProfile = userProfile
    }

    lazy var userName: String = userProfile.userName {
        didSet {
            delegate?.updateUserName(name: userName)
        }
    }

    lazy var userAge: Int = userProfile.userAge {
        didSet {
            delegate?.updateUserAge(age: userAge)
        }
    }
}
