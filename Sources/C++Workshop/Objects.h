//
//  Objects.h
//  
//
//  Created by Mario Guerrieri on 9/9/21.
//

#pragma once

#include <string>

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
    
private:
    holder _holder;
    currency _balance;
};
