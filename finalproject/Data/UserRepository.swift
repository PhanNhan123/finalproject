//
//  UserRepository.swift
//  finalproject
//
//  Created by Test VPN on 01/12/2022.
//  Copyright © 2022 Phan Nhân. All rights reserved.
//

import Foundation
import RxSwift

class UserRepository: Repository {
    
    static let shared = UserRepository()
    
    private let userService:UserServiceProtocol
    
    override init() {
        self.userService = UserService()
    }
    
    func getUsers(since:String) -> Observable<[UserModel]> {
        return userService.getUsers(since: since)
    }
    
    func getUser(username:String) -> Observable<UserModel> {
        return userService.getUser(username: username)
    }
    
    
}

