//
//  HigherOrder.h
//  
//
//  Created by Mario Guerrieri on 8/17/21.
//

#pragma once

@import std.algorithm;

template <typename P>
/// @returns a function with one parameter N that counts all the numbers from 1 to N that satisfy the two-argument predicate function, where the first argument is N and the second argument is the number from 1 to N
/// @parameter predicate(n, i) -> bool
auto count_cond(P predicate) {
    // YOUR CODE HERE
}

template <typename F, typename G>
/// @returns a function which given x, computes f(g(x))
auto compose1(F f, G g) {
    // YOUR CODE HERE
}

template <typename F, typename G>
/// @returns a function with one parameter x that returns True if f(g(x)) is equal to g(f(x)). You can assume the result of g(x) is a valid input for f and vice versa
auto composite_identity(F f, G g) {
    // YOUR CODE HERE
}

template <typename F>
/// @returns a function that, when called with one argument for @c func , returns a function that when called with another
/// argument for @c func, calls @c func with the two provided arguments and returns the result
auto lambda_curry2(F func) {
    return [func](auto lhs) {
        // YOUR CODE HERE
        // We need to call `func(lhs, ...)`; where do we get the other argument from?
    };
}

template <typename F, typename G, typename H>
/// @returns a function that returns a function that cycles through calling the provided functions each time it is called
auto cycle(F f, G g, H h) {
    // YOUR CODE HERE
}
