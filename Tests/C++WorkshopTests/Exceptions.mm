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
        auto val = 0; // Aside: since the `try` block is a scope, keeping `val` inside it helps avoid leaking
                      //        potentially invalid state in the case of an exception
        std::cout << "Enter a number > ";
        std::cin >> val;
        test(val);
    } catch (const std::exception& error) {
        // We're catching both exception types here, since they both derive from `std::exception`.
        std::cout << "Caught '" << error.what() << "'!\n";
    }
}

@end
