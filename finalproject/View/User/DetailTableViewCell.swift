import UIKit
import Nuke

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var infoContentView: UIView!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var avtImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var flLabel: UILabel!
    @IBOutlet weak var gitImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func bind(user: InfoUserModel) {
        nameLabel.text = user.name
        emailLabel.text = user.email
        avtImage.loadURL(user.avatar_url)

        
//        dateLabel.text = user.created_at
        flLabel.text = String(user.followers)
        contentLabel.text = user.bio
   
    }
    
}
