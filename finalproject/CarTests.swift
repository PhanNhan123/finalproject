import XCTest
//@testable import UnitTest
@testable import finalproject
class CarTests: XCTestCase {
    
    var ferrari: Car!
    var jeep: Car!
    var honda: Car!
    
    override func setUp() {
        super.setUp()
        ferrari = Car(type: .Sport, transmissionMode: .Drive)
        jeep = Car(type: .OffRoad, transmissionMode: .Drive)
        honda = Car(type: .Economy, transmissionMode:  .Park)	
    }
    
    override func tearDown() {
        super.tearDown()
        ferrari = nil
        jeep = nil
        honda = nil
    }
    
    func testSportfasterThanJeep(){
        let minutes = 60
        ferrari.start(minutes: minutes)
        jeep.start(minutes: minutes)
        XCTAssertTrue(ferrari.miles >  jeep.miles )
    }
    
}
