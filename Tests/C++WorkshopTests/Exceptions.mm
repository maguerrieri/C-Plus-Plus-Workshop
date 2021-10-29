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
    auto val = 0;
    try {
        std::cout << "Enter a number > ";
        std::cin >> val;
        test(val);
    } catch (const std::exception& error) {
        // We're catching both exception types here, since they both derive from `std::exception`.
        std::cout << "Caught '" << error.what() << "'!\n";
    }
}

@end
