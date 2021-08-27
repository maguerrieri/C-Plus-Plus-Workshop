//
//  FunctionsAndTemplates.mm
//
//
//  Created by Mario Guerrieri on 8/26/21.
//

@import XCTest;

@import std.string;

@import C__Workshop;

@interface FunctionsAndTemplatesTests: XCTestCase

@end

@implementation FunctionsAndTemplatesTests

- (void)testExample1 {
    // Passes fine, as you'd expect.
    XCTAssertEqual(returnArgument(1), 1);
    
    // But, of course, it only works for `int`s.
    using namespace std::string_literals;
//    XCTAssertEqual(returnArgument("Test string"s), "Test string"s); // Compile error!
    
    // An Objective-C method can handle this dynamically.
    XCTAssertEqualObjects([ArgumentReturner returnArgumentWithObject:@1], @1);
    XCTAssertEqualObjects([ArgumentReturner returnArgumentWithObject:@"Test string"], @"Test string");
    
    // But the compiler can't check the types at all anymore! This fails, but not until runtime.
    XCTAssertEqualObjects([ArgumentReturner returnArgumentWithObject:@1], @"Test string");
    // The plain C++ function at least lets the compiler tell us ahead of time that an `int` and a `string` can't be
    // compared!
    XCTAssertEqual(returnArgument(1), "Test string"s);
}

@end
