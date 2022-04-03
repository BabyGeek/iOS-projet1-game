//
//  Player.swift
//  Game
//
//  Created by Paul Oggero on 02/04/2022.
//

import Foundation

class Player {
    let name: String
    var team: [Characterable] = [Characterable]()
    
    init(_ name: String) {
        self.name = name
    }
    
    init(name: String) {
        self.name = name
    }
    
    // Add a character to the player team depending on the type
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