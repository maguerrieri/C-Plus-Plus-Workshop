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
struct account {
    std::string holder_name;
    double balance;
};
