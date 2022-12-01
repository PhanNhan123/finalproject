import Foundation

typealias Dispatch = DispatchQueue

extension Dispatch {
    
    /// Do task in background thread
    static func background(_ task: @escaping () -> ()) {
        Dispatch.global(qos: .background).async {
            task()
        }
    }
    
    /// Do task in main thread
    static func main(_ task: @escaping () -> ()) {
        Dispatch.main.async {
            task()
        }
    }
}
