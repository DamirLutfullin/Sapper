//
//  CellView.swift
//  Sapper
//
//  Created by Damir Lutfullin on 05.07.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

class CellView: UIButton {
    
    private(set) var point: Point
    
    var cellType: CellType = .closed {
        didSet {
            let title: String
            switch cellType {
            case .closed:
                title = "🔒"
            case .flagged:
                title = "🚩"
            case .bombed:
                title = "💣"
            case .isEmpty:
                title = ""
            case .label(value: let value):
                title = String(value)
            }
            setTitle(title, for: .normal)
        }
    }
    
    init(point: Point) {
        self.point = point
        super.init(frame: .zero)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
