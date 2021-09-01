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
    return [predicate](auto n) {
        auto count = 0;
        for (auto i = 1; i <= n; i ++) {
            if (predicate(n, i)) {
                count += 1;
            }
        }
        return count;
    };
}

template <typename F, typename G>
/// @returns a function which given x, computes f(g(x))
auto compose1(F f, G g) {
    return [f, g](auto x) { return f(g(x)); };
}

template <typename F, typename G>
/// @returns a function with one parameter x that returns True if f(g(x)) is equal to g(f(x)). You can assume the result of g(x) is a valid input for f and vice versa
auto composite_identity(F f, G g) {
    return [f, g](auto x) { return f(g(x)) == g(f(x)); };
}

template <typename F>
/// @returns a function that, when called with one argument for @c func , returns a function that when called with another
/// argument for @c func, calls @c func with the two provided arguments and returns the result
auto lambda_curry2(F func) {
    return [func](auto lhs) { return [func, lhs](auto rhs) { return func(lhs, rhs); }; };
}

template <typename F, typename G, typename H>
/// @returns a function that returns a function that cycles through calling the provided functions each time it is called
auto cycle(F f, G g, H h) {
    return [f, g, h](auto function_index) {
        return [f, g, h, function_index](auto x) {
            auto out = x;
            for (auto i = 1; i <= function_index; i ++) {
                switch (i % 3) {
                    case 0:
                        out = h(out);
                        break;
                    case 1:
                        out = f(out);
                        break;
                    case 2:
                        out = g(out);
                        break;
                }
            }
            return out;
        };
    };
}

template <typename SP>
class shared_caller {
    SP _ptr;
    
public:
    shared_caller(SP ptr): _ptr{ptr} { }
    
    auto operator ()(int x) { return (*(this->_ptr))(x); }
};

template <typename F, typename G, typename H>
/// @returns a function that returns a function that cycles through calling the provided functions each time it is called
auto cycle_recursive(F f, G g, H h) {
    auto ret = std::make_shared<std::function<std::function<int(int)>(int)>>();
    *ret = [ret = std::weak_ptr{ret}, f, g, h](auto function_index) {
        return [ret, f, g, h, function_index](auto x) {
            auto& rret = *ret.lock();
            switch (function_index) {
                case 0:
                    return x;
                default: {
                    auto prev = rret(function_index - 1)(x);
                    switch (function_index % 3) {
                        case 0:
                            return h(prev);
                        case 1:
                            return f(prev);
                        case 2:
                            return g(prev);
                    }
                }
            }
        };
    };
    
    return shared_caller{ret};
}
