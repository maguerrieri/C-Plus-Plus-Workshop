//
//  Test.mm
//  
//
//  Created by Mario Guerrieri on 9/28/21.
//

@import XCTest;

#include "Exercises.h"

@interface Test: XCTestCase

@end

@implementation Test

- (void)testMajority {
    XCTAssertEqual(majority_element({2, 8, 7, 2, 2, 5, 2, 3, 1, 2, 2}), (std::optional{2}));
    XCTAssertEqual(majority_element({2, 1, 1, 3, 2, 1, 2, 1, 1, 2, 2}), std::nullopt);
    XCTAssertEqual(majority_element({}), std::nullopt);
    XCTAssertEqual(majority_element({1, 2}), std::nullopt);
    XCTAssertEqual(majority_element({1, 1}), (std::optional{1}));
    XCTAssertEqual(majority_element({1}), (std::optional{1}));
}

- (void)testSubVector {
    XCTAssertEqual(subvector_sum({ 2, 7, 11, 15 }, 9),
                   (subvector_sum_return_t{
        { 2, 7 },
    }));
    
    XCTAssertEqual(subvector_sum({ 2, 7, 11, -2 }, 9),
                   (subvector_sum_return_t{
        { 2, 7 },
        { 11, -2 },
    }));
    
    XCTAssertEqual(subvector_sum({ 4, 2, -3, -1, 0, 4 }, 0),
                   (subvector_sum_return_t{
        { -3, -1, 0, 4 },
        { 0 },
    }));
    
    XCTAssertEqual(subvector_sum({ 3, 4, -7, 3, 1, 3, 1, -4, -2, -2 }, 0),
                   (subvector_sum_return_t{
        { 3, 4, -7 },
        { 4, -7, 3 },
        { -7, 3, 1, 3 },
        { 3, 1, -4 },
        { 3, 1, 3, 1, -4, -2, -2 },
        { 3, 4, -7, 3, 1, 3, 1, -4, -2, -2 },
    }));
}

- (void)testRange {
    XCTAssertEqual(substring_range("testsdkfh", "test")->start, 0);
    XCTAssertEqual(substring_range("012testsdkfh", "test", search_mode::none)->start, 3);
    XCTAssertEqual(substring_range("testsdkfh", "test", search_mode::none, {{ 1, 10 }}), std::nullopt);
    
    auto test = substring_range("test23fdTEST", "test", search_mode::none, {{ 0, 10 }});
    XCTAssert(test.has_value());
    XCTAssertEqual(test->start, 0);
    
    XCTAssertEqual(substring_range("test23fdTEST", "test", search_mode::case_insensitive, {{ 1, 10 }}), std::nullopt);
    XCTAssertEqual(substring_range("test23fdTEST", "test", search_mode::case_insensitive, {{ 1, 20 }})->start, 8);
    XCTAssertEqual(substring_range("0test", "test", search_mode::none, {{ 2, 10 }}), std::nullopt);
    XCTAssertEqual(substring_range("0test", "test", search_mode::none, {{ 1, 10 }})->start, 1);
}

@end
