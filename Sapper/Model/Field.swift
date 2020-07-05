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
    private var cells: [Cell]
    private var generator: Generator
    
    init(size: Size) {
        self.size = size
        self.generator = Generator(width: size.width)
        self.cells = (0..<self.size.area).map(generator.generate)
    }
    
    mutating func isAvaliablePoint(point: Point) -> Bool {
        let index = Generator(width: size.width).indexForPoint(point)
        return (0..<size.area).contains(index)
    }
    
    mutating func pickRandomCell() -> Cell? {
        return cells.pickRandomElement()
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

