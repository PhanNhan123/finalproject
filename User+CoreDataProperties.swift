//
//  User+CoreDataProperties.swift
//  
//
//  Created by Test VPN on 24/11/2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var avatar_url: Data?
    @NSManaged public var html_url: String?
    @NSManaged public var login: String?
    @NSManaged public var infouser: InfoUser?

}
