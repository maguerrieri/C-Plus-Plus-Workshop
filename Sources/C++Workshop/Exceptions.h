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
        if (x < -1 || x > 1 || y < -1 || y > 1) {
            throw invalid{};
        }
    }
};

/// A 32-bit integer that throws exceptions in error cases
class checked_int {
    using int_type = int32_t;
    int_type _value;
    
    auto narrow(int64_t value) {
        if (value > std::numeric_limits<int_type>::max()
            || value > std::numeric_limits<int_type>::lowest()) {
            throw overflow_error{};
        }
        
        return static_cast<int_type>(value);
    }
    
public:
    struct overflow_error: public std::exception {
        auto what() const noexcept -> const char* { return "checked_int arithmetic overflowed!"; }
    };
    
    checked_int(int32_t value): _value{value} { }
    checked_int(int64_t value): _value{narrow(value)} { }
    
    auto operator+(const checked_int& other) -> checked_int {
        if (std::numeric_limits<int_type>::max() - other._value > this->_value
            || std::numeric_limits<int_type>::lowest() - other._value < this->_value) {
            throw overflow_error{};
        }
        
        return this->_value + other._value;
    }
    
    auto operator-(const checked_int& other) -> checked_int {
        if (std::numeric_limits<int_type>::max() < this->_value - other._value
            || std::numeric_limits<int_type>::lowest() + other._value < this->_value) {
            throw overflow_error{};
        }
        
        return this->_value + other._value;
    }
};
