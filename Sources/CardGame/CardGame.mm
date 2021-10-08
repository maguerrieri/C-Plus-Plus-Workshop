//
//  CardGame.cpp
//  
//
//  Created by Mario Guerrieri on 8/19/21.
//

#include "CardGame.h"

@import std.iostream;
@import std.optional;

@import C__Workshop;
@import CardGameSwift;

constexpr auto WELCOME_MESSAGE = "Welcome to Magic: The Lambda-ing!\n"
                                 "\n"
                                 "Your code has taken on a mind of its own and has\n"
                                 "challenged you to a game of cards!\n"
                                 "\n"
                                 "Let's get this duel started, shall we?\n";

class Game {
    static constexpr auto win_score = 8;
    
    Player<RandomDeck>& player;
    int player_score = 0;
    
    Player<RandomDeck>& opponent;
    int opponent_score = 0;
    
    struct Result {
        int player_score;
        int opponent_score;
        std::string description;
    };
    auto round_result(float player_power, float opponent_power) -> Result {
        if (player_power > opponent_power) {
            return { .player_score = 1, .opponent_score = 0, .description = "won" };
        } else if (player_power < opponent_power) {
            return { .player_score = 0, .opponent_score = 1, .description = "lost" };
        } else {
            return { .player_score = 0, .opponent_score = 0, .description = "tied" };
        }
    }
    
public:
    Game(Player<RandomDeck>& player, Player<RandomDeck>& opponent): player{player}, opponent{opponent} { }
    
    class RoundDisplay {
        struct PlayerResult {
            std::string name;
            const Card<RandomDeck>& card;
            float power;
            
            friend auto operator<<(std::ostream& os, const PlayerResult& playerResult) -> std::ostream& {
                os << playerResult.name << "'s "
                   << "card: " << playerResult.card << "; "
                   << "Power: " << playerResult.power << "\n";
                return os;
            }
        };
        
        RoundDisplay(Result result,
                     PlayerResult player_result,
                     PlayerResult opponent_result):
            result{result},
            player_result{player_result},
            opponent_result{opponent_result}
        { }
        
        friend auto operator<<(std::ostream& os, const RoundDisplay& roundDisplay) -> std::ostream& {
            os << "You " << roundDisplay.result.description << " this round!\n";
            os << roundDisplay.player_result;
            os << roundDisplay.opponent_result;
            return os;
        }
        
        Result result;
        PlayerResult player_result;
        PlayerResult opponent_result;
        
        friend class Game;
    };
    
    auto play_round(Card<RandomDeck>& player_card, Card<RandomDeck>& opponent_card) -> RoundDisplay {
        player_card.effect(opponent_card, this->player, this->opponent);
        opponent_card.effect(opponent_card, this->player, this->opponent);
        
        auto player_power = player_card.power(opponent_card);
        auto opponent_power = opponent_card.power(player_card);
        
        auto result = this->round_result(player_power, opponent_power);
        this->player_score += result.player_score;
        this->opponent_score += result.opponent_score;
        
        return {
            result,
            {
                .name = this->player.name(),
                .card = player_card,
                .power = player_power
            },
            {
                .name = this->opponent.name(),
                .card = opponent_card,
                .power = opponent_power
            }
        };
    }
    
    auto winner() -> std::optional<std::reference_wrapper<Player<RandomDeck>>> {
        if (this->player_score < win_score && this->opponent_score < win_score) {
            return std::nullopt;
        } else {
            return this->player_score > this->opponent_score ? this->player : this->opponent;
        }
    }
    
    struct ScoreDisplay {
        std::string player_name;
        int player_score;
        std::string opponent_name;
        int opponent_score;
        
        friend auto operator<<(std::ostream& os, const ScoreDisplay& scoreDisplay) -> std::ostream& {
            os << scoreDisplay.player_name << "'s score: " << scoreDisplay.player_score << "\n";
            os << scoreDisplay.opponent_name << "'s score: " << scoreDisplay.opponent_score << "\n";
            return os;
        }
    };
    
    auto scores() -> ScoreDisplay {
        return {
            .player_name = this->player.name(),
            .player_score = this->player_score,
            .opponent_name = this->opponent.name(),
            .opponent_score = this->opponent_score
        };
    }
};

using LoadedCards = std::vector<Card<RandomDeck>>;
auto load_cards(Cards *cards) -> std::tuple<RandomDeck, LoadedCards> {
    return {{{}}, {}};
}

@implementation CardGame

+ (int)playWithCards:(Cards *)cards {
    std::cout << "What is your name? > ";
    
    auto name = std::string{};
    std::cin >> name;
    
    auto [standard_deck, loaded_cards] = load_cards(cards);
    
    auto player_deck = RandomDeck{{}};
    auto player = Player<RandomDeck>{name, player_deck};
    auto opponent_deck = RandomDeck{{}};
    auto opponent = Player<RandomDeck>{"Opponent", opponent_deck};

    std::cout << WELCOME_MESSAGE;

    auto duel = Game{player, opponent};
    while (true) {
        auto winner = duel.winner();
        if (winner.has_value()) {
            std::cout << (*winner).get().name() << " wins!\n";
            break;
        }

        try {
            player.draw();
            opponent.draw();

            std::cout << player.hand_display();

            auto card_index = Player<RandomDeck>::HandIndex{};
            std::cin >> card_index;
            std::cout << duel.play_round(player.play(card_index - 1), opponent.play());
            std::cout << duel.scores();
        } catch (const Player<RandomDeck>::DrawException& drawException) {
            std::cout << drawException.player.name() << " is out of cards. They lose!\n";
            break;
        }
    }
    
    return 0;
}

@end
