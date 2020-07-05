//
//  GameFieldView.swift
//  Sapper
//
//  Created by Damir Lutfullin on 03.07.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

class GameFieldView: UIView {
    
    weak var delegate: GameFieldDelegate?
    weak var dataSource: GameFieldViewDataSource? {
        didSet {
            setupVeiew()
            reloadData()
        }
    }
    
    override func layoutSubviews() {
        backgroundColor = .white
        super.layoutSubviews()
        guard let fieldSize = dataSource?.size,
            let cells = subviews as? [CellView] else { return }
        
        let dimension = min(bounds.width, bounds.height) / CGFloat(fieldSize.width) // вычисляем минимум из длины и ширины и делаим на количество ячеек в строке,  получаем ширину ячейки
        
        let cellSize = CGSize(width: Int(dimension), height: Int(dimension))
        
        let diff = abs(bounds.width - bounds.height) / 2 // вычисляем пустую зону
        
        var movX: CGFloat = 0
        var movY: CGFloat = 0
        
        if bounds.width > bounds.height {
            movX = diff
        } else {
            movY = diff
        }
        
        for cell in cells {
            cell.frame.size = cellSize
            cell.frame.origin = CGPoint(x: movX + CGFloat(cell.point.x) * dimension,
                                        y: movY + CGFloat(cell.point.y) * dimension)
        }
        
    }
    
    private func setupVeiew() {
        subviews.forEach{ subview in
            subview.removeFromSuperview() }
        
        guard let fieldSize = dataSource?.size else { return }
        for x in 0..<fieldSize.width {
            for y in 0..<fieldSize.height {
                let cell = CellView(point: Point(x: x, y: y))
                cell.addTarget(self, action: #selector(cellTuchUpInside), for: .touchUpInside)
                addSubview(cell)
            }
        }
    }
    
    func reloadData() {
        guard let dataSource = dataSource,
        let cells = subviews as? [CellView] else { return }
        
        for cell in cells {
            cell.cellType = dataSource.getCellTypeAtCoordinates(cell.point)
        }
    }
    
    @objc private func cellTuchUpInside(cell: CellView) {
        delegate?.didSelectCellAtPoint(point: cell.point)
    }
    
    
}
