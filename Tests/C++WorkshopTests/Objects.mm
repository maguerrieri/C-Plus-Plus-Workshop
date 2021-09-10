//
//  Objects.mm
//
//
//  Created by Mario Guerrieri on 9/9/21.
//

@import XCTest;

@import C__Workshop;

@interface Objects: XCTestCase

@end

@implementation Objects

- (void)testExample {
    // Should be familiar from Python, other modern languages (Kotlin, Swift, Rust).
    // Note the curly braces { }; see https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines#Res-list
    auto some_account = account{};
    
    // Simple objects like this one can be constructed with a designated initializer
    auto initialized_account = account{ .holder_name = "Mario", .balance = 1'000'000 };
}

@end
