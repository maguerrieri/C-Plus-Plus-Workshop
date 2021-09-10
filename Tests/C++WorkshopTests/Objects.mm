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
}

@end
