//
//  Asynchrony.mm
//  
//
//  Created by Mario Guerrieri on 11/4/21.
//

@import XCTest;

@import cf;

@import std.iostream;

@interface AsynchronyTests: XCTestCase

@end

@implementation AsynchronyTests

- (void)testAsynchrony {
    // Should be at least vaguely familiar from my past presentations/docs about asynchrony
    cf::async([] {
        // The default default executor for `cf` is a `std::thread`
        std::cout << "Hello from the default executor!\n";
        
        return cf::unit{};
    }).get(); // Blocking on the completion of the future to ensure that the test doesn't end before the async block
              // runs
}

@end
