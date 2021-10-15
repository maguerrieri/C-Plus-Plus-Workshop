//
//  Cards.h
//  
//
//  Created by Mario Guerrieri on 8/17/21.
//

#pragma once

#include <iostream>
#include <random>
#include <string>
#include <vector>

template <typename Deck> class Player;

template <typename Deck>
struct Card {
    std::string name;
    int attack;
    int defense;
    
    virtual auto card_type() const -> std::string { return "Gemmer"; }
    
    Card(std::string name, int attack, int defense): name{name}, attack{attack}, defense{defense} { }
    Card(const Card&) = default;
    
    auto operator ==(const Card& other) const { return this->name == other.name; }
    auto operator !=(const Card& other) const { return this->name != other.name; }
    
    /// @returns card's power; calculate power as: (player card's attack) - (opponent card's defense)/2
    virtual auto power(const Card& opponent_card) const -> float { return this->attack - opponent_card.defense / 2; }
    
    /// Cards have no default effect.
    virtual void effect(Card& opponent_card, Player<Deck>& player, Player<Deck>& opponent) const { }

    friend auto operator <<(std::ostream& os, const Card<Deck>& card) -> std::ostream& {
        os << card.name << ": " << card.card_type() << ", [" << card.attack << ", " << card.defense << "]";
        return os;
    }
};

template <typename Deck>
struct EngCard: public Card<Deck> {
    auto card_type() const -> std::string override { return "Engineer"; }
    
    using Card<Deck>::Card;
    EngCard(const EngCard&) = default;
    
    /// Discard the first 3 cards in the opponent's hand and have them draw the same number of cards from their deck.
    void effect(Card<Deck>& opponent_card, Player<Deck>& player, Player<Deck>& opponent) const override {
        opponent.discard_first();
        opponent.discard_first();
        opponent.discard_first();
        
        opponent.draw();
        opponent.draw();
        opponent.draw();
    }
};

template <typename Deck>
struct QACard: public Card<Deck> {
    auto card_type() const -> std::string override { return "QA"; }
    
    using Card<Deck>::Card;
    QACard(const QACard&) = default;
    
    /// Swap the attack and defense of an opponent's card.
    void effect(Card<Deck>& opponent_card, Player<Deck>& player, Player<Deck>& opponent) const override {
        std::swap(opponent_card.attack, opponent_card.defense);
    };
};

template <typename Deck>
struct PMCard: public Card<Deck> {
    auto card_type() const -> std::string override { return "Product Manager"; }
    
    using Card<Deck>::Card;
    PMCard(const PMCard&) = default;
    
    /// Adds the attack and defense of the opponent's card to all cards in the player's deck, then removes all cards in
    /// the opponent's deck that share an attack or defense stat with the opponent's card.
    void effect(Card<Deck>& opponent_card, Player<Deck>& player, Player<Deck>& opponent) const override {
        for (auto& card : player.deck()) {
            card->attack += opponent_card.attack;
            card->defense += opponent_card.defense;
        }
        
        auto& opponent_deck = opponent.deck();
        for (auto it = opponent_deck.begin(); it != opponent_deck.end(); it ++) {
            auto& other_card = (*it);
            if (other_card->attack == opponent_card.attack
                || other_card->defense == opponent_card.defense) {
                opponent_deck.erase(it);
                it --;
            }
        }
    };
};

template <typename Deck>
class Player {
    using Hand = std::vector<std::unique_ptr<Card<Deck>>>;
    
    std::string _name;
    Deck& _deck;
    Hand _hand;
    
public:
    struct DrawException: public std::exception {
        auto what() const noexcept -> const char* override { return "Deck is empty!"; }
        
        DrawException(const Player<Deck>& player): player{player} { }
        const Player<Deck>& player;
    };
    
    /// A Player starts the game by drawing 5 cards from their deck.
    Player(std::string name, Deck& deck): _name{name}, _deck{deck}, _hand{} {
        for (auto i = 0; i < 5; i ++) { this->draw(); }
    }
    
    const auto& hand() { return this->_hand; }
    auto& deck() { return this->_deck; }
    
    /// Draw a card from the player's deck and add it to their hand.
    void draw() {
        if (this->_deck.empty()) { throw DrawException{*this}; }
        
        this->_hand.emplace_back(this->_deck.draw());
    }
    
    void discard_first() {
        this->_hand.erase(this->_hand.begin());
    }
    
    using HandIndex = typename Hand::size_type;
    
    /// Remove and return a card from the player's hand at the given index.
    auto play(HandIndex index) -> std::unique_ptr<Card<Deck>> {
        auto card = std::move(this->_hand.at(index));
        this->_hand.erase(this->_hand.begin() + index);
        return card;
    }
    
    /// Play a random card.
    auto play() -> std::unique_ptr<Card<Deck>> {
        auto uniform_distribution = std::uniform_int_distribution<HandIndex>{0, this->hand().size() - 1};
        auto generator = std::mt19937{std::random_device{}()};

        return this->play(uniform_distribution(generator));
    }
    
    struct HandDisplay {
        const Hand& hand;
        
        friend auto operator<<(std::ostream& os,
                               const typename Player<Deck>::HandDisplay& handDisplay) -> std::ostream& {
            os << "Your hand: \n";
            for (auto i = 0; i < handDisplay.hand.size(); i ++) {
                os << i + 1 << ": " << handDisplay.hand.at(i) << "\n";
            }
            return os;
        }
    };
    
    auto hand_display() const -> HandDisplay { return HandDisplay{this->_hand}; }
    
    auto name() const -> std::string { return this->_name; }
};
