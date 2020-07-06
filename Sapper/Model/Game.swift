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
        field.generateLabels()
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
    
    private mutating func revealNeighbors(point: Point) {
        guard let cell = field[point], cell.type == .isEmpty else { return }

        let neigbors = field.neighborsCells(around: cell).filter({$0.type != .bomb})
        for neigbor in neigbors {
            if !openedPoints.contains(neigbor.location) {
                openedPoints.insert(neigbor.location)
                if neigbor.type == .isEmpty {
                    revealNeighbors(point: neigbor.location)
                }
            }
        }
    }
    
    mutating func revealCellAtPoint(_ point: Point) {
        openedPoints.insert(point)
        revealNeighbors(point: point)
//        field.neighborsCells(around: field[point]!).forEach { (cell) in
//            print("cell type: \(cell.type), location: \(cell.location)")
//        }
//        print("\n")
    }
}
