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
    } catch (const greater_than_ten_error& error) {
        // Since we caught this specific type of error, we can access its members.
        std::cout << "Caught '" << error.what() << "' with greater value '" << error.greater_value << "'!\n";
    } catch (const less_than_or_equal_to_ten_error& error) {
        // And same for this one.
        std::cout << "Caught '" << error.what() << "' with lesser value '" << error.lesser_value << "'!\n";
    }
}

@end
