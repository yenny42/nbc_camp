//
//  ProfileViewModel.swift
//  Deepening_Profile
//
//  Created by t2023-m0035 on 1/24/24.
//

import Foundation

class ProfileViewModel {
    var userProfile: ProfileInfo?

    init(userProfile: ProfileInfo?) {
        self.userProfile = userProfile
    }

    var userName: String {
        return userProfile?.userName ?? "Please Enter user name"
    }

    var userAge: String {
        return userProfile?.userAge.description ?? "Please Enter user age"
    }
}
