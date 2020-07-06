//
//  GameModel.swift
//  Sapper
//
//  Created by Damir Lutfullin on 03.07.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation

class GameModel {
   
    private(set) var configuration: Configuration = .advanced
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
    
    func getCellTypeAtCoordinates(_ coordinates: Point) -> CellType {
        guard var game = game,
            let cell = game.field[coordinates],
            game.openedPoints.contains(coordinates) else { return .closed }
        
        switch cell.type {
        case .isEmpty:
            return .isEmpty
        case .bomb:
            return .bombed
        case .label(value: let value):
            return .label(value: value)
        }
    }
    
}

struct Configuration {
    var size: Size
    var bombsCount: Int
    
    static let beginner = Configuration(size: Size(width: 9, height: 9), bombsCount: 10)
    
     static let advanced = Configuration(size: Size(width: 30, height: 16), bombsCount: 99)

}
