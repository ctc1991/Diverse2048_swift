//
//  GameManager.swift
//  Diverse2048_swift
//
//  Created by Tech on 16/8/12.
//  Copyright © 2016年 ctc. All rights reserved.
//

import Foundation

class GameManager {
    
    class func uuid() -> String {
        if NSUserDefaults.standardUserDefaults().valueForKey("uuid") == nil {
            NSUserDefaults.standardUserDefaults().setValue(NSUUID().UUIDString, forKey: "uuid")
        }
        return NSUserDefaults.standardUserDefaults().valueForKey("uuid") as! String
    }
    
    class func save(score score: Int, type: CellType) {
        NSUserDefaults.standardUserDefaults().setValue(score, forKey: String(format: "GameManager_Score_%d", type.hashValue))
    }
    
    class func load(type type: CellType) -> Int {
        if NSUserDefaults.standardUserDefaults().valueForKey(String(format: "GameManager_Score_%d", type.hashValue)) != nil {
            return NSUserDefaults.standardUserDefaults().valueForKey(String(format: "GameManager_Score_%d", type.hashValue)) as! Int
        }
        return 0
    }
    
    class func save(game game: Game, type: CellType) {
        var array = Array<Array<Dictionary<String,Int!>>>()
        
        if NSUserDefaults.standardUserDefaults().valueForKey(String(format: "GameManager_Game_%d", type.hashValue)) != nil {
            array = NSUserDefaults.standardUserDefaults().valueForKey(String(format: "GameManager_Game_%d", type.hashValue)) as! Array<Array<Dictionary<String,Int!>>>
        }
        
        array.append(self.game(game: game, type: type))
        
        NSUserDefaults.standardUserDefaults().setValue(array, forKey: String(format: "GameManager_Game_%d", type.hashValue))
    }
    
    class func load(type: CellType) -> Array<Game> {
        var array = Array<Array<Dictionary<String,Int!>>>()
        
        if NSUserDefaults.standardUserDefaults().valueForKey(String(format: "GameManager_Game_%d", type.hashValue)) != nil {
            array = NSUserDefaults.standardUserDefaults().valueForKey(String(format: "GameManager_Game_%d", type.hashValue)) as! Array<Array<Dictionary<String,Int!>>>
        }
        
        var games = Array<Game>()
        
        
        for gameInfo in array {
            let game = Game()
            var cells = Array<Cell>()
            for dictionary in gameInfo {
                let cell = Cell()
                cell.index = dictionary["index"]
                cell.score = dictionary["score"]!
                cell.row = dictionary["row"]
                cell.column = dictionary["column"]
                game.score = dictionary["gameScore"]!
                cells.append(cell)
            }
            game.cells = cells
            games.append(game)
        }
        return games
    }
    
    class func removeAllGames(type: CellType) {
        var array = Array<Array<Dictionary<String,Int!>>>()
        
        if NSUserDefaults.standardUserDefaults().valueForKey(String(format: "GameManager_Game_%d", type.hashValue)) != nil {
            array = NSUserDefaults.standardUserDefaults().valueForKey(String(format: "GameManager_Game_%d", type.hashValue)) as! Array<Array<Dictionary<String,Int!>>>
        }
        array.removeAll()
        NSUserDefaults.standardUserDefaults().setValue(array, forKey: String(format: "GameManager_Game_%d", type.hashValue))
    }
    
    class func game(game game: Game, type: CellType) -> Array<Dictionary<String,Int!>> {
        var array = Array<Dictionary<String,Int!>>()
        for cell in game.cells {
            let dictionary = ["index":cell.index,"score":cell.score,"row":cell.row,"column":cell.column,"gameScore":game.score]
            array.append(dictionary)
        }
        return array
    }
}