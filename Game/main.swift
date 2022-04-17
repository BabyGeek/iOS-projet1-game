//
//  main.swift
//  Game
//
//  Created by Paul Oggero on 01/04/2022.
//

import Foundation


// Fast description of the game
print(introduction)

if let _ = readLine() {
    print(doubleSeparator)

    // Create a game instance to store the datas to show all over the game process
    var game = Game()
    
    // Ask for the first player name and store it
    print("Enter first player name: ")
    if let playerOneName = readLine() {
        game.addPlayer(playerOneName)
    }
    
    print(separator)
    
    // Ask for second player name and store it
    print("Enter second player name: ")
    if let playerTwoName = readLine() {
        game.addPlayer(playerTwoName)
    }
    
    print(separator)
    
    // Check if 2 players where correctcly created
    if game.players.count != 2 {
        print(errorPlayerNumber)
        exit(0)
    }
    
    // Preparing the players to select there teams
    print(selectionTeamIntroduction)
    
    print(doubleSeparator)
    
    print("Team selection for: \(game.players.first!.name)")

    // Selection for player One and Two
    game.makePlayerSelectCharacter(game.players.first!)
    
    print(doubleSeparator)

    print("Team selection for: \(game.players.last!.name)")

    // Selection for player Two
    game.makePlayerSelectCharacter(game.players.last!)
    
    print(doubleSeparator)
    
    // Remembering players the teams
    print(playersTeamsRemindDescription)
    game.getPlayersTeams()
    
    //Starting Battle
    print(doubleSeparator)
    print(battleBegins)
    
    // Launch the game battle
    game.battle()
    
    // Ending battle
    print(doubleSeparator)
    print(battleEnds)
    
    print(separator)
    
    print("Reminder of the teams played.")
    game.getPlayersTeams()
    
    print(separator)
    
    print("Stats of the game:")
    print("Winner: \(game.getPlayerWon())")
    print("Number of turns: \(game.getTotalTurns())")
    print("Time played: \(game.getTimePlayed(type: "m")) minutes")
}

