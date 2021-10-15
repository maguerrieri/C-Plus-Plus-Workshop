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
    using Card = Card<Impl>;
    using Cards = std::vector<std::unique_ptr<Card>>;
    Cards _cards;
    
    static auto copy_cards(const Cards& cards) {
        auto out = Cards{};
        std::transform(cards.begin(), cards.end(), std::back_inserter(out), [](auto& card) {
            return std::make_unique<Card>(*card);
        });
        return out;
    }
    
public:
    using size_type = typename decltype(_cards)::size_type;
    using iterator = typename decltype(_cards)::iterator;
    
    Deck(Cards&& cards): _cards{std::move(cards)} { }
    Deck(const Cards& cards): _cards{copy_cards(cards)} { }
    Deck(const Deck& other): Deck{copy_cards(other._cards)} { }
    auto operator=(const Deck& other) {
        this->_cards = copy_cards(other._cards);
    }
    
    auto empty() const { return this->_cards.empty(); }
    auto size() const { return this->_cards.size(); };
    
    auto at(size_type index) const -> const typename Cards::value_type& { return this->_cards.at(index); }
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
    
    auto draw() -> std::unique_ptr<Card>;
};
