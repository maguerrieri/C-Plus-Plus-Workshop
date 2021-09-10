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
    
    // BUT because these objects are stored as values (not indirectly), we can't (safely) dynamically use the derived
    // type in place of its base type; the compiler lets us do this assignment but anything in `savings` that isn't in
    // an `account` has been "sliced" off.
    account sliced_savings = another_savings;
//    sliced_account._rate; // it's just an `account`, so this member doesn't exist!
//    XCTAssertEqual(sizeof(another_savings), 40);
//    XCTAssertEqual(sizeof(sliced_savings), 32); // the sliced object is 8 bytes smaller!
    
    // If we want to use polymorphism, we need to reference our objects indirectly (more details on `shared_ptr` in the
    // next session; it behaves generally like an Objective-C ARC strong pointer), and mark member functions as
    // `virtual`.
    std::shared_ptr<account> account_ptr;
    account_ptr = std::make_shared<savings_account>(another_savings);
    account_ptr->update(not_std_yet::chrono::years{1});
    XCTAssertGreaterThan(account_ptr->balance().amount, 1'100'000); // Used the derived implementation!
    
    // Also important: if we might deallocate objects from a hierarchy via a base class pointer (like we have here),
    // that class needs a `virtual` destructor!
}

@end
