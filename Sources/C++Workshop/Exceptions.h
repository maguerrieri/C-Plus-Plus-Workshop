//
//  Exceptions.h
//  
//
//  Created by Mario Guerrieri on 10/29/21.
//

#pragma once

#include <limits>
#include <stdexcept>

/// A point that contains values in the space x ~ [-1, 1], y ~ [-1, 1]
class normalized_point {
    float _x;
    float _y;
    
public:
    struct invalid: public std::exception {
        auto what() const noexcept -> const char* { return "normalized_point coordinates must be in [-1, 1]"; }
    };
    
    normalized_point(float x, float y): _x{x}, _y{y} {
        /* YOUR CODE HERE */
    }
};

/// A 32-bit integer that throws exceptions in error cases
class checked_int {
    using int_type = int32_t;
    int_type _value;
    
public:
    struct overflow_error: public std::exception {
        auto what() const noexcept -> const char* { return "checked_int arithmetic overflowed!"; }
    };
    
    checked_int(int32_t value): _value{/* YOUR CODE HERE */} { }
    checked_int(int64_t value): _value{/* YOUR CODE HERE */} { }
    
    auto operator+(const checked_int& other) -> checked_int {
        /* YOUR CODE HERE */
    }
    
    auto operator-(const checked_int& other) -> checked_int {
        /* YOUR CODE HERE */
    }
};
