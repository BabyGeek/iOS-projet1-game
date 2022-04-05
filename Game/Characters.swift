//
//  Characters.swift
//  Game
//
//  Created by Paul Oggero on 02/04/2022.
//

import Foundation

// Enumerator for the character types
enum CharacterType: Int, CaseIterable {
    case warrior = 1, magus, colossus, dwarf
    
    
    /// Define a more undestandable description for the player choice
    var RPGType: String {
        switch self {
        case .warrior, .dwarf:
            return "DPS"
        case .magus:
            return "HEAL"
        case .colossus:
            return "TANK"
        }
    }
    
    /// Helps for the attack selection if the type of character can heal
    var canHeal: Bool {
        return self == .magus
    }
    
}

/// Base Characterable class
class Characterable {
    var name: String
    var hp: Int
    let maxHP: Int
    var damages: Int
    var type: CharacterType
    
    
    /// Init a character
    /// - Parameters:
    ///   - name: Name of the character
    ///   - hp: Base HP of the character
    ///   - damages: Damages deal by the attack of the character
    ///   - type: Type of the character
    init(name: String, hp: Int, damages: Int, type: CharacterType) {
        self.name = name
        self.hp = hp
        self.maxHP = hp
        self.damages = damages
        self.type = type
        
    }
    
    
    /// Remove HPs to the character
    /// - Parameter damages: Amount of HPs to remove
    func getDamaged(_ damages: Int) {
        self.hp -= damages
        
        if self.hp < 0 {
            self.hp = 0
        }
        
    }
    
    
    /// Add Hps to the character
    /// - Parameter heal: Amount of HPs to add
    func getHealed(_ heal: Int) {
        self.hp += heal
        
        if self.hp > self.maxHP {
            self.hp = self.maxHP
        }
    }
}

// Classes that define the current 4 types of characters

class Warrior: Characterable {
    init(name: String) {
        super.init(name: name, hp: 100, damages: 10, type: .warrior)
    }
}

class Magus: Characterable {
    
    init(name: String) {
        super.init(name: name, hp: 150, damages: 5, type: .magus)
    }
}

class Colossus: Characterable {
    init(name: String) {
        super.init(name: name, hp: 150, damages: 15, type: .colossus)
    }
}

class Dwarf: Characterable {
    init(name: String) {
        super.init(name: name, hp: 50, damages: 20, type: .dwarf)
    }
}
