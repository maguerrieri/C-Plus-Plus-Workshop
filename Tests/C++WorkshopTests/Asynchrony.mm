//
//  Asynchrony.mm
//  
//
//  Created by Mario Guerrieri on 11/4/21.
//

@import XCTest;

@import cf;

@import std.iostream;

@interface AsynchronyTests: XCTestCase

@end

@implementation AsynchronyTests

- (void)testAsynchrony {
    auto executor = cf::async_thread_pool_executor{1};
    auto executor_2 = cf::async_thread_pool_executor{1};
    
    // Should be at least vaguely familiar from my past presentations/docs about asynchrony
    auto future = cf::async(executor, [] {
        // The default default executor for `cf` is a `std::thread`
        std::cout << "Hello from the default executor!\n";
        
        return cf::unit{};
    })
    .then([](auto unit_future) {
        // Runs sequentially, on the same executor (in this case, the same thread that was created for the initial
        // `async` block)
        std::cout << "Hello from a continuation on the same executor!\n";
        
        return cf::unit{};
    })
    .then(executor_2, [](auto future) {
        std::cout << "Hello from a continuation on a different executor!\n";
        
        return cf::unit{};
    })
    .then([](auto unit_future) {
        // Runs sequentially, on the same executor (in this case, the same thread that was created for the initial
        // `async` block)
        std::cout << "Hello from a continuation on the same thread executor!\n";
        
        return cf::unit{};
    })
    .then(executor, [](auto unit_future) {
        // Runs sequentially, on the same executor (in this case, the same thread that was created for the initial
        // `async` block)
        std::cout << "Hello from a continuation on the thread executor!\n";
        
        throw std::runtime_error{"oops!"};
        return cf::unit{};
    });
    
    auto future_2 = cf::future<cf::unit>{};
    
    try {
        future_2.get();
    } catch (const std::exception& e) {
        std::cout << "Caught '" << e.what() << "'!\n";
    }
}

@end
