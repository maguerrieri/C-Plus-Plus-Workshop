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
};
struct less_than_or_equal_to_ten_error: std::exception {
    auto what() const noexcept -> const char* override { return "Value is less than or equal to ten!"; }
};

void test(int val) {
    if (val > 10) {
        throw greater_than_ten_error{};
    } else {
        throw less_than_or_equal_to_ten_error{};
    }
}
