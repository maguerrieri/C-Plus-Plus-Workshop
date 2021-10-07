//
//  Cards_helper.h
//  
//
//  Created by Mario Guerrieri on 8/18/21.
//

#pragma once

#include <vector>

template <typename Deck> class Card;

template <typename Impl>
class Deck {
protected:
    using Cards = std::vector<Card<Impl>>;
    Cards _cards;
    
public:
    using size_type = typename decltype(_cards)::size_type;
    using iterator = typename decltype(_cards)::iterator;
    
    Deck(const Cards& cards): _cards{cards} { }
    Deck(const Deck&) = default;
    
    auto empty() const { return this->_cards.empty(); }
    auto size() const { return this->_cards.size(); };
    
    auto at(size_type index) const { return this->_cards.at(index); }
    void erase(iterator it) { this->_cards.erase(it); }
    
    auto begin() { return this->_cards.begin(); }
    auto end() { return this->_cards.end(); }
};

class RandomDeck: Deck<RandomDeck> {
public:
    using Deck::Cards;
    
    using Deck::Deck;
    using Deck::empty;
    using Deck::size;
    using Deck::at;
    using Deck::erase;
    using Deck::begin;
    using Deck::end;
    
    auto draw() -> Card<RandomDeck>;
};
