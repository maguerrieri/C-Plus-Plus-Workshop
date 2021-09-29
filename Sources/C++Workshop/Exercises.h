//
//  Exercises.h
//  
//
//  Created by Mario Guerrieri on 9/28/21.
//

#pragma once

#include <optional>
#include <string>
#include <unordered_set>
#include <vector>

auto majority_element(const std::vector<int>& votes) -> std::optional<int>;

struct vector_hash {
    // https://stackoverflow.com/a/27216842/2205941
    auto operator()(std::vector<int> vector) const -> size_t {
        auto ret = std::size_t{0};
        for(auto& i : vector) {
            ret ^= std::hash<uint32_t>()(i);
        }
        return ret;
    }
};
using subvector_sum_return_t = std::unordered_set<std::vector<int>, vector_hash>;
auto subvector_sum(const std::vector<int>& vector, int target) -> subvector_sum_return_t;

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
