//
//  InfoUser+CoreDataProperties.swift
//  
//
//  Created by Test VPN on 24/11/2022.
//
//

import Foundation
import CoreData


extension InfoUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InfoUser> {
        return NSFetchRequest<InfoUser>(entityName: "InfoUser")
    }

    @NSManaged public var avatar_url: Data?
    @NSManaged public var bio: String?
    @NSManaged public var created_at: Date?
    @NSManaged public var email: String?
    @NSManaged public var followers: Int64
    @NSManaged public var login: String?
    @NSManaged public var name: String?

}
