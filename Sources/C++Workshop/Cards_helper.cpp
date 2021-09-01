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

auto RandomDeck::draw() -> Card<RandomDeck>& {
    assert(!this->_cards.empty());
    
    auto uniform_distribution = std::uniform_int_distribution<size_type>{0, this->_cards.size() - 1};
    auto generator = std::mt19937{std::random_device{}()};
    
    auto random_iterator = this->_cards.begin() + uniform_distribution(generator);
    auto random_card = *random_iterator;
    
    this->_cards.erase(random_iterator);
    
    return random_card;
}

#pragma mark - Card definitions

auto mario = EngCard<RandomDeck>{"Mario, Techpriest Enginseer", 1337, 1003};
auto ken = EngCard<RandomDeck>{"Ken, Code Contortionist", 7544, 2382};
auto steven = EngCard<RandomDeck>{"Steven, Code Monkey", 2352, 23425};
auto adrian = EngCard<RandomDeck>{"Adrian, Noodle Soup Eater", 1803, 2229};
auto aleks = EngCard<RandomDeck>{"Aleks, Missing From The Team Page", 3243, 6271};

auto cindy = QACard<RandomDeck>{"Cindy, Off-World Colonies Replicant Representative", 7053, 4572};
auto fletch = QACard<RandomDeck>{"Fletch, Game Breaker", 9999, 9999};

auto eitan = PMCard<RandomDeck>{"Eitan, Hakuna Matataer", 9944, 5552};
auto haerin = PMCard<RandomDeck>{"Haerin, COVID Chef", 2298, 4594};

auto standard_deck = RandomDeck{{ mario, ken, steven, adrian, aleks, cindy, fletch, eitan, haerin }};
auto player_deck = RandomDeck{standard_deck};
auto opponent_deck = RandomDeck{standard_deck};
