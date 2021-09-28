//
//  Exercises.h
//  
//
//  Created by Mario Guerrieri on 9/28/21.
//

#pragma once

#include <optional>
#include <string>
#include <vector>

auto majority_element(const std::vector<int>& votes) -> std::optional<int>;
auto subvector_sum(const std::vector<int>& vector, int target) -> std::vector<std::vector<int>>;

template <typename T>
struct range {
    typename T::size_type start;
    typename T::size_type end;
};
enum class search_mode {
    none,
    backwards,
    case_insensitive,
};
auto substring_range(const std::string& to_search,
                     const std::string& to_find,
                     search_mode mode = search_mode::none,
                     std::optional<range<std::string>> range_to_search = std::nullopt)
    -> std::optional<range<std::string>>;
