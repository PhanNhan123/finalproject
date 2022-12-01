import Foundation
import UIKit

struct InfoUserModel : Codable{
    let name: String
    let avatar_url: String
    let bio: String
    let followers: Int64
    let email: String
    let created_at: Date
    let login: String
}
