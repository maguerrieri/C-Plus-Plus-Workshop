//
//  FunctionsAndTemplates.h
//  
//
//  Created by Mario Guerrieri on 8/17/21.
//

#pragma once

@import Foundation;

// Plain old C-like function (with a little bit of newfangled C++ syntax).
auto returnArgument(int value) -> int {
   return value;
}

@interface ArgumentReturner: NSObject

+ (id)returnArgumentWithObject:(id)object;

@end

@implementation ArgumentReturner

+ (id)returnArgumentWithObject:(id)object {
    return object;
}

@end
