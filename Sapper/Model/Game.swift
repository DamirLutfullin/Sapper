//
//  Game.swift
//  Sapper
//
//  Created by Damir Lutfullin on 03.07.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation

struct Game {
    
    private let initialLocation: Point
    private let bombsCount: Int
    var openedPoints: Set<Point>
    var field: Field
    
    init(size: Size, initialLocation: Point, bombsCount: Int) {
        self.field = Field(size: size)
        self.bombsCount = bombsCount
        self.initialLocation = initialLocation
        openedPoints = []
        
        putBombs()
    }
    
    private func generateBombsLocation() -> [Point] {
        var field = self.field
        field[initialLocation] = nil
        
        return (0..<bombsCount).compactMap { _ in
            field.pickRandomCell()?.location
        }
    }
    
    private mutating func putBombs() {
        for location in generateBombsLocation() {
            field[location]?.type = .bomb
        }
    }
    
    mutating func revealCellAtPoint(_ point: Point) {
        openedPoints.insert(point)
    }
}
