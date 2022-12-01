import Foundation

extension String {
    
    /// Initializes an NSURL object with a provided URL string.
    var url: URL? {
        return URL(string: self)
    }
}
