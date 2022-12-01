import SwiftyBeaver

/**
 Logger manager to manage all logs by enviroment configuration
 using 3rd library SwiftyBeaver
 */
struct Logger {
    /// SwiftyBeaver library
    private static var log: SwiftyBeaver.Type = {
        let console = ConsoleDestination()
        let logger = SwiftyBeaver.self
        logger.addDestination(console)
        return logger
    }()
    
    /// VERBOSE log
    static func v(_ message:Any) {
        log.verbose(message)
    }
    
    /// DEBUG log
    static func d(_ message:Any) {
        // Do not log it in production enviroment
        #if DEBUG
        log.debug(message)
        #endif
    }
    
    /// INFO log
    static func i(_ message:Any) {
        log.info(message)
    }
    
    /// ERROR log
    static func e(_ message:Any) {
        log.error(message)
    }
}
