//
//  Extension Array.swift
//  Sapper
//
//  Created by Damir Lutfullin on 03.07.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation

extension RangeReplaceableCollection where Index == Int {
    mutating func pickRandomElement() -> Element? {
        guard !isEmpty else { return nil }
        let randomIndex = Int.random(in: startIndex..<endIndex)
        let element = self[randomIndex]
        self.remove(at: randomIndex)
        return element
    }
}
