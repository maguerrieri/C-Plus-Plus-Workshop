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
//    XCTAssertEqual(returnArgumentBlock(1), @"Test string");
    
    // C++ lambdas work similarly, but even the parameter type can be inferred!
    auto return_argument_lambda = [](auto value) { return value; };
    XCTAssertEqual(return_argument_lambda(1), 1);
    
    // ...and since the return type is based on the parameter type, these all work.
    XCTAssertEqual(return_argument_lambda("Test string"s), "Test string"s);
    XCTAssertEqual(return_argument_lambda(&test_value), &test_value);
    
    // Effectively, the compiler has created a one-off function template for our lambda (it's actually an object with a
    // template call operator, but we'll get to that later).
    
    // One last thing: Lambda value capture. Again effectively the same as in Objective-C, but a bit more explicit.
    auto* someString = @"Test!";
    auto someBlock = ^{ XCTAssertEqualObjects(someString, @"Test!"); };
    someBlock();
    
    auto some_string = "Test!"s;
    auto some_lambda = [some_string] { XCTAssertEqual(some_string, "Test!"s); };
    some_lambda();
    
    // Captures being explicit gives you some more options of what to capture. The default for capturing a variable
    // (previous example) is by-value.
    auto another_lambda = [&some_string] { some_string = "Not 'test!'!"; };
    another_lambda(); // Since we captured a _reference_ to `some_string`, this has a side effect.
    XCTAssertEqual(some_string, "Not 'test!'!"s);
    
    auto yet_another_lambda = [some_other_name_for_the_string = some_string] {
        // Captured by value still, but bound to a new name.
        XCTAssertEqual(some_other_name_for_the_string, "Not 'test!'!"s);
    };
    yet_another_lambda();
    
    // One more note: capturing pointers is _non-owning_! This is consistent with C++ in general, but might be
    // surprising coming from Objective-C with ARC.
    std::function<void()> captures_dangling_pointer;
    {
        auto will_be_destroyed = 10;
        captures_dangling_pointer = [will_dangle = &will_be_destroyed] { XCTAssertEqual(*will_dangle, 10); };
    }
    // `will_be_destroyed` is now out of scope
    captures_dangling_pointer(); // Undefined behavior! In a program this simple the assert will likely still pass,
                                 // but this code is incorrect.
}

@end
