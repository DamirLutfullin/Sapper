//
//  Cell.swift
//  Sapper
//
//  Created by Damir Lutfullin on 03.07.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation

struct Cell {
    let location: Point
    var type: Type = .isEmpty
    
    init(location: Point) {
        self.location = location
    }
    
    enum `Type`: Equatable {
        case isEmpty
        case bomb
        case label (value: Int)
    }
}

