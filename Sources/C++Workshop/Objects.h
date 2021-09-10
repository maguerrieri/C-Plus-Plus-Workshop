//
//  Objects.h
//  
//
//  Created by Mario Guerrieri on 9/9/21.
//

#pragma once

#include <chrono>
#include <cmath>
#include <string>

// These are in the standard library starting in C++20...
namespace not_std_yet {
namespace chrono {
using years = std::chrono::duration<std::chrono::seconds::rep, std::ratio<31556952>>;
}

namespace numbers {
constexpr double e = 2.71828182845904523536028747135266249775724709369995;
}
}

// The only difference between structs and classes is that
// structs' members are public by default and classes' are private.
class account {
public:
    // See https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines#p1-express-ideas-directly-in-code
    struct currency { double amount; };
    struct holder { std::string name; };
    
    // See https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines#c40-define-a-constructor-if-a-class-has-an-invariant
    // and subsequent guidelines
    account(const holder& holder, const currency& balance): _holder{holder}, _balance{balance} {
        if (this->_holder.name.size() == 0 || this->_balance.amount < 0) {
            throw std::runtime_error{"Invalid account parameters"};
        }
    }
    
    static constexpr auto rate = 0.05;
    void update(not_std_yet::chrono::years delta) {
        this->_balance.amount *= std::pow(not_std_yet::numbers::e, rate * delta.count());
    }
    
    auto balance() -> const currency& { return this->_balance; };
    
private:
    holder _holder;
    currency _balance;
};
