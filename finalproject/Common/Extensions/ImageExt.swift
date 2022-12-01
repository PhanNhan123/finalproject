
import UIKit
import Nuke

extension UIImageView {
    
    /// Use Nuke library to load image by url
    func loadURL(_ url: String?) {
        Nuke.loadImage(with: URL(string: url!)!, into: self)
    }
}
