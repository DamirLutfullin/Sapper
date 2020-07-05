//
//  GameModel.swift
//  Sapper
//
//  Created by Damir Lutfullin on 03.07.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation

class GameModel {
   
    private(set) var configuration: Configuration = .beginner
    private(set) var game: Game?
    
    func restart() {
        game = nil
    }
    
    func revealCellAtPoint(point: Point) {
        if game == nil {
            game = Game(size: configuration.size, initialLocation: point, bombsCount: configuration.bombsCount)
        }
        game?.revealCellAtPoint(point)
    }
    
}

struct Configuration {
    var size: Size
    var bombsCount: Int
    
    static let beginner = Configuration(size: Size(width: 9, height: 9), bombsCount: 10)
}
