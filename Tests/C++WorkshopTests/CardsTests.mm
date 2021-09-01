@import XCTest;

@import C__Workshop;

@interface Cards: XCTestCase

@end

namespace Test {

class Deck: ::Deck<Deck> {
    using Super = ::Deck<Deck>;
    
public:
    using ::Deck<Deck>::Cards;
    
public:
    using size_type = decltype(_cards)::size_type;
    
    using Super::Deck;
    using Super::empty;
    using Super::size;
    using Super::at;
    using Super::erase;
    using Super::begin;
    using Super::end;
    
    auto draw() -> Card<Deck>& {
        auto card = this->_cards.front();
        this->_cards.erase(this->_cards.begin());
        return card;
    };
};

using Card = Card<Deck>;
using EngCard = EngCard<Deck>;
using QACard = QACard<Deck>;
using PMCard = PMCard<Deck>;
using Player = Player<Deck>;

#pragma mark - Card definitions

auto mario = EngCard{"Mario, Techpriest Enginseer", 1337, 1003};
auto ken = EngCard{"Ken, Code Contortionist", 7544, 2382};
auto steven = EngCard{"Steven, Code Monkey", 2352, 23425};
auto adrian = EngCard{"Adrian, Noodle Soup Eater", 1803, 2229};
auto aleks = EngCard{"Aleks, Missing From The Team Page", 3243, 6271};

auto cindy = QACard{"Cindy, Off-World Colonies Replicant Representative", 7053, 4572};
auto fletch = QACard{"Fletch, Game Breaker", 9999, 9999};

auto eitan = PMCard{"Eitan, Hakuna Matataer", 9944, 5552};
auto haerin = PMCard{"Haerin, COVID Chef", 2298, 4594};
auto wen = PMCard{"Wen, Global Nomad", 427, 4140};

auto standard_deck = Deck{{ mario, ken, steven, adrian, aleks, cindy, fletch, eitan, haerin }};
auto player_deck = Deck{standard_deck};
auto opponent_deck = Deck{standard_deck};

void reset_deck(Deck& deck) { deck = Deck{standard_deck}; }

}

auto test_deck(std::vector<Test::Card>& cards) {
    auto card_references = Test::Deck::Cards{};
    std::transform(cards.begin(), cards.end(), std::back_inserter(card_references), [](auto& card) {
        return decltype(card_references)::value_type{card};
    });
    return Test::Deck{card_references};
}

@implementation Cards

- (void)setUp {
    Test::reset_deck(Test::player_deck);
    Test::reset_deck(Test::opponent_deck);
}

- (void)testCardConstructor {
    using namespace std::string_literals;
    
    auto staff_member = Test::Card{"staff", 400, 300};
    XCTAssertEqual(staff_member.name, "staff");
    XCTAssertEqual(staff_member.attack, 400);
    XCTAssertEqual(staff_member.defense, 300);
    
    auto other_staff = Test::Card{"other", 300, 500};
    XCTAssertEqual(other_staff.attack, 300);
    XCTAssertEqual(other_staff.defense, 500);
}

- (void)testCardPower {
    auto staff_member = Test::Card{"staff", 400, 300};
    auto other_staff = Test::Card{"other", 300, 500};
    XCTAssertEqual(staff_member.power(other_staff), 150.0);
    XCTAssertEqual(other_staff.power(staff_member), 150.0);
    
    auto third_card = Test::Card{"third", 200, 400};
    XCTAssertEqual(staff_member.power(third_card), 200.0);
    XCTAssertEqual(third_card.power(staff_member), 50.0);
}

- (void)testPlayerConstructor {
    auto test_card = Test::Card{"test", 100, 100};
    auto test_deck = Test::Deck{Test::Deck::Cards(6, test_card)};
    auto test_player = Player{"tester", test_deck};
    XCTAssertEqual(test_deck.size(), 1);
    XCTAssertEqual(test_player.hand().size(), 5);
}

- (void)testPlayerDraw {
    auto test_card = Test::Card{"test", 100, 100};
    auto test_deck = Test::Deck{Test::Deck::Cards(6, test_card)};
    auto test_player = Test::Player{"tester", test_deck};
    test_player.draw();
    XCTAssertEqual(test_deck.size(), 0);
    XCTAssertEqual(test_player.hand().size(), 6);
}

- (void)testPlayerPlay {
    auto test_deck = Test::Deck{{Test::cindy, Test::fletch, Test::eitan, Test::haerin, Test::wen}};
    auto test_player = Test::Player{"tester", test_deck};
    XCTAssertEqual(test_player.play(0), Test::cindy);
    XCTAssertEqual(test_player.play(0), Test::fletch);
    XCTAssertEqual(test_player.hand().size(), 3);
}

- (void)testEngCardEffect {
    auto player1 = Test::Player{"p1", Test::player_deck};
    auto player2 = Test::Player{"p2", Test::opponent_deck};
    auto opponent_card = Test::Card{"other", 500, 500};
    auto tutor_test = Test::EngCard{"Eng", 500, 500};
    auto initial_deck_length = Test::opponent_deck.size();
    tutor_test.effect(opponent_card, player1, player2);
    XCTAssertEqual(player2.hand().size(), 5);
    XCTAssertEqual(Test::opponent_deck.size(), initial_deck_length - 3);
}

- (void)testQACardEffect {
    auto player1 = Test::Player{"p1", Test::player_deck};
    auto player2 = Test::Player{"p2", Test::opponent_deck};
    auto other_card = Test::Card{"other", 300, 600};
    auto qa_test = Test::QACard{"TA", 500, 500};
    qa_test.effect(other_card, player1, player2);
    XCTAssertEqual(other_card.attack, 600);
    XCTAssertEqual(other_card.defense, 300);
}

- (void)testPMCardEffect {
    auto test_card = Test::Card{"card", 300, 300};
    auto pm_test = Test::PMCard{"Product manager", 500, 500};
    auto opponent_card = test_card;
    
    auto player_cards = std::vector(8, test_card);
    auto player_deck = test_deck(player_cards);
    
    auto opponent_cards = std::vector(8, test_card);
    auto opponent_deck = test_deck(opponent_cards);
    
    auto player1 = Test::Player{"p1", player_deck};
    auto player2 = Test::Player{"p2", opponent_deck};
    pm_test.effect(opponent_card, player1, player2);
    for (auto& card : player1.deck()) {
        XCTAssertEqual(card.get().attack, 600);
        XCTAssertEqual(card.get().defense, 600);
    }
    XCTAssertEqual(player2.deck().size(), 0);
}

@end
