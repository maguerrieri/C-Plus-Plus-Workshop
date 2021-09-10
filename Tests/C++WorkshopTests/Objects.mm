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
//    auto some_account = account{};
    
    // Simple objects like this one can be constructed with a designated initializer
//    auto initialized_account = account{ .holder_name = "Mario", .balance = 1'000'000 };
    
    // But as types get more complicated (and need to enforce invariants), they should provide a constructor
//    try {
//        auto new_account = account{{ .name = "Mario" }, { .amount = 1'000'000 }};
//        auto other_account = account{{ .name = "Mario" }, { .amount = -1000 }};
//    } catch (const std::exception&) {
//        XCTFail(@"Oops!");
//    }
    
    // Member functions should be familiar from other languages as well
    auto another_account = account{{ .name = "Mario" }, { .amount = 1'000'000 }};
    another_account.update(not_std_yet::chrono::years{1});
    XCTAssertGreaterThan(another_account.balance().amount, 1'050'000);
    
    // Same for (public) inheritance
//    auto savings = savings_account{{ .name = "Mario" }, { .amount = 1'000'000 }, { .rate = 0.1 }};
    
    // We can add and change members
    auto another_savings = savings_account{{ .name = "Mario" }, { .amount = 1'000'000 }, { .rate = 0.1 }};
}

@end
