//
//  File.swift
//  
//
//  Created by Mario Guerrieri on 9/23/21.
//

import Foundation

@objc
public class CardInfo: NSObject, Codable {
    @objc public let name: String
    @objc public let attack: Int
    @objc public let defense: Int
}

@objc
public class Cards: NSObject, Codable {
    @objc public let name: String
    
    @objc public let cards: [CardInfo]
}

public enum Error: Swift.Error {
    case failed
}

public func loadCards() throws -> Cards {
    guard let url = Bundle.main.urls(forResourcesWithExtension: "bundle", subdirectory: nil)?.first,
          let bundle = Bundle(url: url) else {
              throw Error.failed
          }
    
    guard let cardsJSONURL = bundle.url(forResource: "cards", withExtension: "json") else {
        throw Error.failed
    }
    
    return try JSONDecoder().decode(Cards.self, from: .init(contentsOf: cardsJSONURL))
}
