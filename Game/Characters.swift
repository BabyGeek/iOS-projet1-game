//
//  Characters.swift
//  Game
//
//  Created by Paul Oggero on 02/04/2022.
//

import Foundation

// Protocol that all characters have to adopt
protocol Characterable {
    var name: String { get set }
    var hp: Int { get set }
    var maxHP: Int { get }
    var damages: Int { get }
    var type: CharacterType { get }
    
    
    func getDamaged(_ damages: Int) -> Void
    func getHealed(_ heal: Int) -> Void
}

// Enumerator for the character types
enum CharacterType: Int, CaseIterable {
    case warrior = 1, magus, colossus, dwarf
    
    // Define a more undestandable description for the player choice
    var RPGType: String {
        switch self {
        case .warrior:
            return "DPS"
        case .magus:
            return "HEAL"
        case .colossus:
            return "TANK"
        case .dwarf:
            return "HDPS"
        }
    }
    
    // Helps for the attack selection if the type of character can heal
    var canHeal: Bool {
        switch self {
        case .magus:
            return true
        default:
            return false
        }
    }
    
}


// Classes that define the current 4 types of characters

class Warrior: Characterable {
    var maxHP: Int = 100
    
    var name: String
    
    var hp: Int = 100
    
    var damages: Int = 10
    
    var type: CharacterType = .warrior
    
    init(name: String) {
        self.name = name
    }
    
    func getDamaged(_ damages: Int) {
        
        self.hp -= damages
        
        if self.hp < 0 {
            self.hp = 0
        }
        
    }
    
    func getHealed(_ heal: Int) {
        self.hp += heal
        
        if self.hp > self.maxHP {
            self.hp = self.maxHP
        }
    }
}

class Magus: Characterable {
    var maxHP: Int = 150
    
    var name: String
    
    var hp: Int = 150
    
    var damages: Int = 5
    
    var type: CharacterType = .magus
    
    init(name: String) {
        self.name = name
    }
    
    func getDamaged(_ damages: Int) {
        
        self.hp -= damages
        
        if self.hp < 0 {
            self.hp = 0
        }
        
    }
    
    func getHealed(_ heal: Int) {
        self.hp += heal
        
        if self.hp > self.maxHP {
            self.hp = self.maxHP
        }
    }
}

class Colossus: Characterable {
    var maxHP: Int = 150
    
    var name: String
    
    var hp: Int = 150
    
    var damages: Int = 15
    
    var type: CharacterType = .colossus
    
    init(name: String) {
        self.name = name
    }
    
    func getDamaged(_ damages: Int) {
        
        self.hp -= damages
        
        if self.hp < 0 {
            self.hp = 0
        }
        
    }
    
    func getHealed(_ heal: Int) {
        self.hp += heal
        
        if self.hp > self.maxHP {
            self.hp = self.maxHP
        }
    }
}

class Dwarf: Characterable {
    var maxHP: Int = 50
    
    var name: String
    
    var hp: Int = 50
    
    var damages: Int = 20
    
    var type: CharacterType = .dwarf
    
    init(name: String) {
        self.name = name
    }
    
    func getDamaged(_ damages: Int) {
        
        self.hp -= damages
        
        if self.hp < 0 {
            self.hp = 0
        }
        
    }
    
    func getHealed(_ heal: Int) {
        self.hp += heal
        
        if self.hp > self.maxHP {
            self.hp = self.maxHP
        }
    }
}
