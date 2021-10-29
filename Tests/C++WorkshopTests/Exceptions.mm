//
//  Exceptions.mm
//  
//
//  Created by Mario Guerrieri on 10/28/21.
//

@import XCTest;

@import C__Workshop;

@import std.iostream;
@import std.stdexcept;

@interface ExceptionsTests: XCTestCase

@end

@implementation ExceptionsTests

- (void)testExceptions {
    try {
        test(); // Exception still thrown, and...
    } catch (const std::runtime_error& error) {
        std::cout << "Caught '" << error.what() << "'!\n"; // we can get information about the error out of the exception object.
    }
}

@end
