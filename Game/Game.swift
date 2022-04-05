//
//  Game.swift
//  Game
//
//  Created by Paul Oggero on 02/04/2022.
//

import Foundation


struct Game {
    var players: [Player] = [Player]()
    var characterNames = [String]()
    
    var turns: Int = 0
    var isRunning: Bool = true
    var playerWon: Player = Player("None")
    
    let began: Double = Date().timeIntervalSince1970
    
    // Store a new player if the name isn't empty
    mutating func addPlayer(_ playerName: String) {
        if !playerName.isEmpty {
            players.append(Player(name: playerName))
        }
    }
    
    // Ask for a given player to select a character until his team isn't complete
    mutating func makePlayerSelectCharacter(_ player: Player) {
        // Telling the player the number character he is selecting
        print("Selecting \(player.team.count + 1) team character \n")
        
        // Showing the player the choices of characters
        for charEnum in CharacterType.allCases {
            print("\(charEnum.rawValue) - \(charEnum) - \(charEnum.RPGType)")
        }
        
        
        print(makeCharacterSelection)
        
        // Waiting for player choice
        if let selected = readLine() {
            // Checking if the player correctly used integer to select
            if let intSelected = Int(selected) {
                // Getting the type selected by the player
                if let selectedType = CharacterType(rawValue: intSelected) {
                    // Getting the name from the player for this character
                    let characterName = getCharacterName()
                    
                    // Adding the character to the player team
                    player.addCharacter(type: selectedType, name: characterName)
                } else {
                    // Showing the error if the selection is incorrect (example: asking for number 5 choice when they are only 4
                    print(errorCharacterSelection)
                }
                
            }else {
                // Showing the error if the player doesn't select with integer
                print(errorNotIntSelected)
            }
        }
        
        
        // If the player has less than 3 characters in his team make another selection
        if player.team.count < 3 {
            print(separator)
            makePlayerSelectCharacter(player)
        }
    }
    
    // Ask for to a player to give a character name and check if this name isn't already in use in the game
    mutating func getCharacterName() -> String {
        print(chooseCharacterName)
        
        // Asking the name of the character to the player
        if let characterName = readLine() {
            // Checking if this name already exists in the game or not
            if characterNames.contains(characterName) {
                
                // Showing the error name already in use and asking a new name
                print(characterNameAlreadyInUse)
                return getCharacterName()
            } else {
                
                // Adding the name to used names in game and returning the name for the character creation in player team
                characterNames.append(characterName)
                return characterName
            }
        } else {
            // Showgin error with the name, let the player enter a name again
            print(errorCharacterName)
            return getCharacterName()
        }
    }
    
    // Get the players teams details before starting battle and after ending battle
    func getPlayersTeams() {
        for player in players {
            print("\(player.name) team: \n")
            
            for character in player.team {
                print("\t - \(character.name):")
                print("\t\t - \(character.type.RPGType)")
                print("\t\t - ❤️ : \(character.hp)/\(character.maxHP)")
                print("\t\t - ⚔️ : \(character.damages) \n")
            }
        }
    }
    
    // Battle loop
    mutating func battle() {
        // Check current player turn
        var currentPlayerIndex = 0
        if turns % 2 == 1 {
            currentPlayerIndex = 1
        }
        
        let currentPlayer = self.players[currentPlayerIndex]
        print("------------ \(currentPlayer.name) TURN -----------")
        
        // Let the player choose a character to play with
        print("\nChoose a character to play with:")
        if let selectedCharacter = selectCharacter(currentPlayer) {
            // Display possible actions with the character
            displayActions(selectedCharacter)
            
            // Waiting for player action choice
            if let selected = readLine() {
                // Checking if the player correctly used integer to select
                if let intSelected = Int(selected) {
                    // Getting the character selected by the player
                    if (intSelected == 2 && !selectedCharacter.type.canHeal) || intSelected < 1 || intSelected > 2 {
                        // Showing the error if the selection is incorrect (example: asking for healing when using a warrior or an index out of bounds (1, 2), then re ask the player to choose until good choice
                        print(errorCharacterSelection)
                        battle()
                        
                    } else {
                        executeAction(intSelected, currentPlayerIndex: currentPlayerIndex, selectedCharacter: selectedCharacter)
                        
                        // Add a turn
                        self.turns += 1
                        // Check if the game is ended
                        self.isFinished()
                        // Go back to another turn
                        if self.isRunning {
                            battle()
                        }
                    }
                }else {
                    // Showing the error if the player doesn't select with integer and reselect action
                    print(errorNotIntSelected)
                    battle()
                }
            }
        }
    }
    
    func selectCharacter(_ player: Player) -> Characterable? {
        for index in player.team.indices {
            
            if player.team[index].hp > 0 {
                // If alive display normal
                print("\(index + 1) - \(player.team[index].name)")
            } else {
                // If died display skull and strikethrought the name (not working in CLI with no 3rd party lib)
                print("\(index + 1) - \(player.team[index].name) ☠️")
            }
        }
        
        
        // Waiting for player choice
        if let selected = readLine() {
            // Checking if the player correctly used integer to select
            if let intSelected = Int(selected) {
                // Getting the character selected by the player
                if intSelected - 1 < 0 || intSelected - 1 > player.team.count {
                    // Showing the error if the selection is incorrect (example: asking for number 4 choice when they are only 3, then re ask the player to choose until good choice
                    print(errorCharacterSelection)
                    return selectCharacter(player)
                    
                } else {
                    // get the selected character
                    let selectedCharacter = player.team[intSelected - 1]
                    
                    // check if the character is still alive, if not make the player knows and select another character
                    if selectedCharacter.hp == 0 {
                        print(errorCharacterSelectedDied)
                        return selectCharacter(player)
                    }
                    
                    return selectedCharacter
                }
                
            }else {
                // Showing the error if the player doesn't select with integer and reselect
                print(errorNotIntSelected)
                return selectCharacter(player)
            }
        }
        
        return nil
    }
    
    func displayActions(_ character: Characterable) {
        // Display choices attack / heal depending on the character
        print("\nSelect an action:")
        
        print("1. Attack the ennemy")
        
        if character.type.canHeal {
            print("2. Heal an ally")
        }
        
    }
    
    func executeAction(_ selectedAction: Int, currentPlayerIndex: Int, selectedCharacter: Characterable) {
        let currentPlayer = currentPlayerIndex == 0 ? players[0] : players[1]
        let ennemyPlayer = currentPlayerIndex == 0 ? players[1] : players[0]
        
        // If player selected attack
        if selectedAction == 1 {
            print("\nChoose a character to attack:")
            // get ennemy player
            // get player selection for attack
            if let selectedAttack = selectCharacter(ennemyPlayer) {
                // Apply the damages
                selectedAttack.getDamaged(selectedCharacter.damages)
                
                // Show to the player what happened
                print("\n\(selectedCharacter.name) attacked \(selectedAttack.name) and has done \(selectedCharacter.damages) damages with his weapon, \(selectedAttack.name) has \(selectedAttack.hp) HP left")
            }
            
        } else if selectedAction == 2 {
            print("\nChoose a character to heal:")
            // get ally player to heal
            if let selectedHealed = selectCharacter(currentPlayer) {
                // if selected is already max HP, tell it to the player but continue the turn
                if selectedHealed.hp == selectedHealed.maxHP {
                    print("\nYou healed \(selectedHealed.name), but the character was already full HP.\n")
                }else {
                    // Apply the heal done to the character selected
                    selectedHealed.getHealed(selectedCharacter.damages * 3)
                    
                    // Show to the player what happened
                    print("\n\(selectedCharacter.name) healed \(selectedHealed.name) and has done \(selectedCharacter.damages) heal with his weapon, \(selectedHealed.name) has now \(selectedHealed.hp) HP left")
                }
            }
        }
    }
    
    func getPlayerWon() -> String {
        return self.playerWon.name
    }
    
    func getTotalTurns() -> Int {
        return self.turns + 1
    }
    
    
    /// Return the duration of the game in the type asked
    /// - Parameter type: String
    /// - Returns: Double
    func getTimePlayed(type: String) -> Double {
        switch type {
        case "s":
            return Date().timeIntervalSince1970 - self.began
        case "m":
            return (Date().timeIntervalSince1970 - self.began) / 60
        case "h":
            return (Date().timeIntervalSince1970 - self.began) / 3600
        default:
            return Date().timeIntervalSince1970 - self.began
        }
    }
    
    
    mutating func isFinished() {
        for player in self.players {
            if !player.team.contains(where: {
                $0.hp > 0
            }) {
                self.isRunning = false
                self.playerWon = players.filter {
                    $0.name != player.name
                }.first!
                break
            }
        }
    }
}
