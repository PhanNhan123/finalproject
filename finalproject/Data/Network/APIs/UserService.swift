//
//  UserService.swift
//  MvvmArchitecture
//
//  Created by thinhlh on 12/21/20.
//  Copyright © 2020 Hitachi Vantara. All rights reserved.
//

import RxSwift

/// UserService
/// Make all request APIs of USER domain
enum UserPath {
    case users(since: String)
    case user(username: String)
    var path : String {
        switch self {
        case .users(let since):
            return "users?since=\(since)"
        case .user(let username):
            return "users/\(username)"
        }
    }
}

protocol UserServiceProtocol {
    func getUsers(since : String) -> Observable<[UserModel]>
    func getUser(username : String) -> Observable<UserModel>
}

class UserService: BaseService,  UserServiceProtocol {
    func getUsers(since: String) -> Observable<[UserModel]> {
        let path = UserPath.users(since: since).path
        return get(path: path, parameters: nil)
    }
    
    func getUser(username: String) -> Observable<UserModel> {
        let path = UserPath.user(username: username).path
        return get(path: path, parameters: nil)
    }
}


