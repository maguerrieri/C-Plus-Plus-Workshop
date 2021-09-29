//
//  Exercises.cpp
//  
//
//  Created by Mario Guerrieri on 8/26/21.
//

#include "Exercises.h"

#include <iostream>

template <typename T>
auto operator<<(std::ostream& os, const std::vector<T>& vector) -> std::ostream& {
    os << "[";
    for (const auto& element : vector) {
        os << element << ", ";
    }
    os << "]";
    return os;
}

auto majority_element(const std::vector<int>& votes) -> std::optional<int> {
    return {}; // YOUR CODE HERE
}

auto subvector_sum(const std::vector<int>& vector, int target) -> std::vector<std::vector<int>> {
    return {}; // YOUR CODE HERE
}

auto substring_range(const std::string& to_search,
                     const std::string& to_find,
                     search_mode mode,
                     std::optional<range<std::string>> range_to_search) -> std::optional<range<std::string>> {
    return {}; // YOUR CODE HERE
}
