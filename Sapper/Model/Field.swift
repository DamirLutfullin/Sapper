//
//  Field.swift
//  Sapper
//
//  Created by Damir Lutfullin on 03.07.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation

struct Field {
    private var size: Size
    var cells: [Cell]
    private var generator: Generator
    
    init(size: Size) {
        self.size = size
        self.generator = Generator(width: size.width)
        self.cells = (0..<self.size.area).map(generator.generate)
    }
    
    func isAvaliablePoint(point: Point) -> Bool {
       return (0..<size.width) ~= point.x && (0..<size.height) ~= point.y
    }
    
    mutating func pickRandomCell() -> Cell? {
        return cells.pickRandomElement()
    }
    
    mutating func generateLabels() {
        let minedCells = cells.filter(Cell.isBomb)
        
        let bombNeighbors = Set<Cell>(minedCells
            .flatMap(neighborsCells)
            .filter(Cell.isNotBomb))
        
        for bombNeighbor in bombNeighbors {
            let label = neighborsCells(around: bombNeighbor).reduce(0) { (result, cell) -> Int in
                return cell.type == .bomb ? result + 1 : result
            }
            self[bombNeighbor.location]?.type = .label(value: label)
        }
        
    }
    
    func neighborsCells(around cell: Cell) -> [Cell] {
        let points = [Point(x: -1, y: 1),
                      Point(x: 0, y: 1),
                      Point(x: 1, y: 1),
                      Point(x: 1, y: 0),
                      Point(x: 1, y: -1),
                      Point(x: 0, y: -1),
                      Point(x: -1, y: -1),
                      Point(x: -1, y: 0)]
        var field = self
        return points
            .map{$0 + cell.location}
            .filter(isAvaliablePoint)
            .compactMap({field[$0]})
    }
    
    subscript(point: Point) -> Cell? {
        mutating get {
            guard isAvaliablePoint(point: point) else { return nil }
            return cells[Generator(width: size.width).indexForPoint(point)]
        }
        set {
            guard isAvaliablePoint(point: point) else { return }
            let index = Generator(width: size.width).indexForPoint(point)
            if let cell = newValue {
                cells[index] = cell
            } else {
                cells.remove(at: index)
            }
        }
    }
}

fileprivate struct Generator {
    let width: Int
    
    func generate(index: Int) -> Cell {
        let point = pointForIndex(index)
        return Cell(location: point)
    }
    
    func pointForIndex(_ index: Int) -> Point {
        let x = index % width
        let y = index / width
        return Point(x: x, y: y)
    }
    
    func indexForPoint(_ point: Point) -> Int {
        return point.y * width + point.x
    }
}

