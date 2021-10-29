//
//  Exceptions.h
//  
//
//  Created by Mario Guerrieri on 10/28/21.
//

#pragma once

#include <stdexcept>

struct greater_than_ten_error: std::exception {
    auto what() const noexcept -> const char* override { return "Value is greater than ten!"; }
    
    greater_than_ten_error(int value): greater_value{value} { }
    int greater_value;
};
struct less_than_or_equal_to_ten_error: std::exception {
    auto what() const noexcept -> const char* override { return "Value is less than or equal to ten!"; }
    
    less_than_or_equal_to_ten_error(int value): lesser_value{value} { }
    int lesser_value;
};

void test(int val) {
    if (val > 10) {
        throw greater_than_ten_error{val};
    } else {
        throw less_than_or_equal_to_ten_error{val};
    }
}
