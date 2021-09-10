@import XCTest;

@import std.compat.cmath;

@import C__Workshop;

@interface HigherOrder: XCTestCase

@end

@implementation HigherOrder

- (void)testCountCond {
    auto count_factors = count_cond([](auto n, auto i) { return n % i == 0; });
    XCTAssertEqual(count_factors(2), // 1, 2
                   2);
    XCTAssertEqual(count_factors(4), // 1, 2, 4
                   3);
    XCTAssertEqual(count_factors(12), // 1, 2, 3, 4, 6, 12
                   6);

    auto count_primes = count_cond([count_factors](auto n, auto i) { return count_factors(i) == 2; });
    XCTAssertEqual(count_primes(2), // 2
                   1);
    XCTAssertEqual(count_primes(3), // 2, 3
                   2);
    XCTAssertEqual(count_primes(4), // 2, 3
                   2);
    XCTAssertEqual(count_primes(5), // 2, 3, 5
                   3);
    XCTAssertEqual(count_primes(20), // 2, 3, 5, 7, 11, 13, 17, 19
                   8);
}

- (void)testCompositeIdentity {
    auto add_one = [](auto x) { return x + 1; }; // adds one to x
    auto square = [](auto x) { return std::pow(x, 2); };
    auto a1 = compose1(square, add_one); // (x + 1)^2
    XCTAssertEqual(a1(4), 25);

    auto mul_three = [](auto x) { return x * 3; }; // multiplies x by 3
    auto a2 = compose1(mul_three, a1); // ((x + 1)^2) * 3
    XCTAssertEqual(a2(4), 75);
    XCTAssertEqual(a2(5), 108);

    auto b1 = composite_identity(square, add_one);
    XCTAssert(b1(0)); // (0 + 1)^2 == 0^2 + 1
    XCTAssertFalse(b1(4)); // (4 + 1)^2 != 4^2 + 1
}

- (void)testLambdaCurry {
    auto add = [](auto lhs, auto rhs) { return lhs + rhs; };
    
    auto some_number = 3;
    auto add_some_number = [add, some_number](auto rhs) { return add(some_number, rhs); };
    
    XCTAssertEqual(lambda_curry2(add)(3)(5), 8);

    auto curried_add = lambda_curry2(add);
    auto add_three = curried_add(3);
    XCTAssertEqual(add_three(5), 8);
    XCTAssertEqual(add_three(10), 13);
    XCTAssertEqual(add_three(2), 5);

    auto mul = [](auto lhs, auto rhs) { return lhs * rhs; };
    XCTAssertEqual(lambda_curry2(mul)(5)(42), 210);

    auto mod = [](auto lhs, auto rhs) { return lhs % rhs; };
    XCTAssertEqual(lambda_curry2(mod)(123)(10), 3);
}

- (void)testCycle {
    auto add1 = [](auto x) { return x + 1; };
    auto times2 = [](auto x) { return x * 2; };
    auto add3 = [](auto x) { return x + 3; };
    auto my_cycle = cycle(add1, times2, add3);

    auto identity = my_cycle(0);
    XCTAssertEqual(identity(5), 5);

    auto add_one_then_double = my_cycle(2);
    XCTAssertEqual(add_one_then_double(1), 4); // times2(add1(1))

    auto do_all_functions = my_cycle(3);
    XCTAssertEqual(do_all_functions(2), 9); // add3(times2(add1(2)))

    auto do_more_than_a_cycle = my_cycle(4);
    XCTAssertEqual(do_more_than_a_cycle(2), 10); // add1(add3(times2(add1(2))))

    auto do_two_cycles = my_cycle(6);
    XCTAssertEqual(do_two_cycles(1), 19); // add3(times2(add1(add3(times2(add1(1))))))
}

@end
