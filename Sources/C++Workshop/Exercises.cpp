//
//  Exercises.cpp
//  
//
//  Created by Mario Guerrieri on 8/26/21.
//

#include "Exercises.h"

#include <unordered_map>

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
    auto counts = std::unordered_map<int, int>{};
    auto max = std::optional<int>{std::nullopt};
    auto max_count = 0;
    auto update_max = [&max, &max_count](auto element, auto count) {
        if (count > max_count) {
            max = element;
            max_count = count;
        } else if (count == max_count) {
            max = std::nullopt;
        }
    };
    for (const auto& element : votes) {
        auto count_it = counts.find(element);
        if (count_it != counts.end()) {
            auto& count = (*count_it).second;
            count += 1;
            update_max(element, count);
        } else {
            counts[element] = 1;
            update_max(element, 1);
        }
    }
//    for (auto& pair : counts) {
//        std::cout << pair.first << ": " << pair.second << "\n";
//    }
//    std::cout << "max: " << (max.has_value() ? std::to_string(*max) : "nullopt") << "\n"
//              << "max_count: " << max_count << "\n"
//              << "---------\n";
    return max;
}

auto subvector_sum(const std::vector<int>& vector, int target) -> subvector_sum_return_t {
    using iterator_t = std::vector<int>::const_iterator;
    using ranges_t = std::vector<std::pair<iterator_t, iterator_t>>;
    using partial_ranges_t = std::vector<std::pair<iterator_t, int>>;
    
    auto helper = std::function<ranges_t(iterator_t, partial_ranges_t)>{};
    helper = [target, &helper, end = vector.end(), &vector](auto begin, auto ongoing) -> ranges_t {
        if (begin == end) { return {}; }
        
//        std::cout << "vector: " << vector << "\n";
//        std::cout << "begin: " << *begin << "\n";
        
        auto ranges = ranges_t{};
        auto new_ongoing = partial_ranges_t{};
        
        if (*begin == target) {
//            std::cout << "Starting range at " << *begin << "; done already" << "\n";
            ranges.emplace_back(begin, begin + 1);
        } else {
//            std::cout << "Starting range at " << *begin << "\n";
            new_ongoing.emplace_back(begin, *begin);
        }
        
        for (auto [ongoing_begin, start_val] : ongoing) {
//            std::cout << "Looking at " << *ongoing_begin << "–..., " << start_val << " accumulated so far \n";
            auto current_val = start_val + *begin;
            if (current_val == target) {
//                std::cout << "Range done, emplacing " << *ongoing_begin << "–" << *begin << "\n";
                ranges.emplace_back(ongoing_begin, begin + 1);
            }
            
//            std::cout << "Continuing range from " << *ongoing_begin << "–..., " << start_val << " accumulated so far \n";
            new_ongoing.emplace_back(ongoing_begin, current_val);
        }
        
        auto next_ranges = helper(begin + 1, new_ongoing);
        std::move(next_ranges.begin(), next_ranges.end(), std::back_inserter(ranges));
        
        return ranges;
    };
    
    auto ranges = helper(vector.begin(), {});
    auto out_vectors = subvector_sum_return_t{};
    std::transform(ranges.begin(), ranges.end(), std::inserter(out_vectors, out_vectors.end()), [](const auto& range) {
        return std::vector<int>{range.first, range.second};
    });
//    std::cout << "-------------------\n";
//    for (auto [begin, end] : ranges) {
//        std::cout << std::vector<int>{begin, end} << "\n";
//    }
//    std::cout << "-------------------\n";
    return out_vectors;
}

auto substring_range(const std::string& to_search,
                     const std::string& to_find,
                     search_mode mode,
                     std::optional<range<std::string>> range_to_search) -> std::optional<range<std::string>> {
    auto string_view = std::string_view{to_search};
    auto actual_range_to_search = range_to_search.value_or(range<std::string>{0, to_search.size()});
    auto to_search_view = (range_to_search.has_value()
                           ? string_view.substr(range_to_search->start, range_to_search->length())
                           : string_view);
    switch (mode) {
        case search_mode::none: {
            auto pos = to_search_view.find(to_find);
            if (pos != std::string::npos) {
                return {{pos + actual_range_to_search.start, to_find.length()}};
            }
            break;
        }
        case search_mode::backwards: {
            auto pos = to_search_view.rfind(to_find);
            if (pos != std::string::npos) {
                return {{pos + actual_range_to_search.start}};
            }
            break;
        }
        case search_mode::case_insensitive: {
            auto pos = std::search(to_search_view.begin(),
                                   to_search_view.end(),
                                   to_find.begin(),
                                   to_find.end(),
                                   [](char first,
                                      char second) { return std::toupper(first) == std::toupper(second); });
            if (pos != to_search_view.end()) {
                return {{
                    pos - to_search_view.begin() + actual_range_to_search.start,
                    to_find.length()
                }};
            }
            break;
        }
    }
    
    return std::nullopt;
}
