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
    XCTAssertEqual(returnArgument("Test string"s), "Test string"s); // Compile error!
}

@end
