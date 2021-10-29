//
//  Cards_helper.cpp
//  
//
//  Created by Mario Guerrieri on 8/17/21.
//

#include "Cards_helper.h"

#include <algorithm>
#include <random>

#include "Cards.h"

auto RandomDeck::draw() -> std::unique_ptr<Card> {
    assert(!this->_cards.empty());
    
    auto uniform_distribution = std::uniform_int_distribution<size_type>{0, this->_cards.size() - 1};
    auto generator = std::mt19937{std::random_device{}()};
    
    auto random_iterator = this->_cards.begin() + uniform_distribution(generator);
    auto random_card = std::move(*random_iterator);
    
    this->_cards.erase(random_iterator);
    
    return random_card;
}
