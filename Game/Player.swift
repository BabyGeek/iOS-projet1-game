//
//  Player.swift
//  Game
//
//  Created by Paul Oggero on 02/04/2022.
//

import Foundation

/// Player class to handle players
class Player {
    let name: String
    var team: [Characterable] = [Characterable]()
    
    init(_ name: String) {
        self.name = name
    }
    
    init(name: String) {
        self.name = name
    }
    
    
    /// Add a character to the player team depending on the type
    /// - Parameters:
    ///   - type: Type of the character to add
    ///   - name: Name of the character to add
    func addCharacter(type: CharacterType, name: String) {
        switch type {
        case .warrior:
            self.team.append(Warrior(name: name))
        case .magus:
            self.team.append(Magus(name: name))
        case .colossus:
            self.team.append(Colossus(name: name))
        case .dwarf:
            self.team.append(Dwarf(name: name))
        }
    }
}
