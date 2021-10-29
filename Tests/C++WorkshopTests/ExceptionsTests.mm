//
//  ExceptionsTests.mm
//  
//
//  Created by Mario Guerrieri on 10/29/21.
//

@import XCTest;

@import C__Workshop;

@interface ExceptionsTests: XCTestCase

@end

@implementation ExceptionsTests

- (void)testNormalizedPoint {
    XCTAssertNoThrow((normalized_point{0.5, 0.5}));
    XCTAssertNoThrow((normalized_point{-0.5, -0.5}));
    XCTAssertThrows((normalized_point{10, 10}));
    XCTAssertThrows((normalized_point{100, -10}));
}

- (void)testCheckedInt {
    XCTAssertThrows((checked_int{std::numeric_limits<int64_t>::max()}));
    XCTAssertThrows((checked_int{std::numeric_limits<int32_t>::max()} + 10));
    XCTAssertThrows((checked_int{std::numeric_limits<int32_t>::lowest()} + -10));
    XCTAssertNoThrow((checked_int{std::numeric_limits<int32_t>::max()} - 10));
}

@end
