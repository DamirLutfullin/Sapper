//
//  GameFieldViewDataSource.swift
//  Sapper
//
//  Created by Damir Lutfullin on 03.07.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation

enum CellType {
    case closed
    case flagged
    case bombed
    case isEmpty
    case label(value: Int)
}

protocol GameFieldViewDataSource: class {
    var size: Size { get }
    func getCellTypeAtCoordinates(_ coordinates: Point) -> CellType
    
}

protocol GameFieldDelegate: class {
    func didSelectCellAtPoint(point: Point)
}
