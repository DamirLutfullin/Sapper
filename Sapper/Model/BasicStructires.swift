//
//  BasicStructires.swift
//  Sapper
//
//  Created by Damir Lutfullin on 03.07.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation

struct Point: Equatable, Hashable {
    let x: Int
    let y: Int
    
    static func +(lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

struct Size {
    let width : Int
    let height: Int
    
    var area: Int {
        return width * height
    }
}
