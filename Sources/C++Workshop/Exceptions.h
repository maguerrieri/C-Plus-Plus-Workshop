//
//  Exceptions.h
//  
//
//  Created by Mario Guerrieri on 10/28/21.
//

#pragma once

#include <stdexcept>

void test() {
    throw std::runtime_error{"Failed!"};
}
