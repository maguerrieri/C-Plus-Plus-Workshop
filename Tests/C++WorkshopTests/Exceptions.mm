//
//  Exceptions.mm
//  
//
//  Created by Mario Guerrieri on 10/28/21.
//

@import XCTest;

@import C__Workshop;

@import std.iostream;

@interface ExceptionsTests: XCTestCase

@end

@implementation ExceptionsTests

- (void)testExceptions {
    try {
        test(); // Exception still thrown, but...
    } catch (const std::exception&) {
        std::cout << "Caught!\n"; // we can handle that!
    }
}

@end
