//
//  ViewController.swift
//  Sapper
//
//  Created by Damir Lutfullin on 03.07.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    @IBOutlet var gameView: GameFieldView!
    let gameModel = GameModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameView.dataSource = self
        gameView.delegate = self
    }
}


extension GameController: GameFieldViewDataSource, GameFieldDelegate {
    
    var size: Size {
        return gameModel.configuration.size
    }
    
    func getCellTypeAtCoordinates(_ coordinates: Point) -> CellType {
        guard var game = gameModel.game, let cell = game.field[coordinates], game.openedPoints.contains(coordinates) else { return .closed }
        switch cell.type {
        case .isEmpty:
            return .isEmpty
        case .bomb:
            return .bombed
        case .label(value: let value):
            return .label(value: value)
        }
    }
    
    func didSelectCellAtPoint(point: Point) {
        
    }
    
}
