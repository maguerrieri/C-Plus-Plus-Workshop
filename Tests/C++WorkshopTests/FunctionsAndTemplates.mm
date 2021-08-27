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
//    XCTAssertEqualObjects([ArgumentReturner returnArgumentWithObject:@1], @"Test string");
    // The plain C++ function at least lets the compiler tell us ahead of time that an `int` and a `string` can't be
    // compared!
//    XCTAssertEqual(returnArgument(1), "Test string"s);
    
    // Enter function templates! I've only written one template but by providing `string` as a template argument I can
    // "stamp out" a version that works for `string`s.
    XCTAssertEqual(returnArgument<std::string>("Test string"s), "Test string"s);
    
    // I don't even need to explicitly provide the template arguments; in most cases the compiler can figure them out
    auto test_value = 10;
    XCTAssertEqual(returnArgument(&test_value), &test_value); // returnArgument<int*>(...)
    
    // Compare to an Objective-C block.
    auto returnArgumentBlock = ^(int value) { return value; };
    // The compiler figured out the return type, so this works fine
    XCTAssertEqual(returnArgumentBlock(1), 1);
    // ...and this fails to compile.
    XCTAssertEqual(returnArgumentBlock(1), @"Test string");
}

@end
