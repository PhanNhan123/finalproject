
import Foundation

/**
 Enviroment configuration
 */
public enum Environment {
    
    /// Define info key
    enum Keys {
        static let baseUrl = "BASE_URL"
    }
    
    /// Get info by key
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    /// Get base url
    static let baseURL: URL = {
        guard let stringValue = Environment.infoDictionary[Keys.baseUrl] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        guard let value = URL(string: stringValue) else {
            fatalError("Root URL is invalid")
        }
        return value
    }()
}


