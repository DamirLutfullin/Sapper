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
            setupView()
            reloadData()
        }
    }
    
    var size: CGFloat {
        return UIFont.preferredFont(forTextStyle: .largeTitle).lineHeight
    }
    
    private func setupView() {
        guard let superview = superview, let fieldSize = dataSource?.size
             else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: CGFloat(fieldSize.width) * size),
            heightAnchor.constraint(equalToConstant: CGFloat(fieldSize.height) * size),
            
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
        
        for subview in subviews {
            subview.removeFromSuperview()
        }
        
        for x in 0..<fieldSize.width {
            for y in 0..<fieldSize.height {
                let point = Point(x: x, y: y)
                let cell = CellView(point: point)
                addSubview(cell)
                
                let xOffset = CGFloat(x) * size
                let yOffset = CGFloat(y) * size
                
                NSLayoutConstraint.activate([
                    cell.widthAnchor.constraint(equalToConstant: size),
                    cell.heightAnchor.constraint(equalToConstant: size),
                    cell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: xOffset),
                    cell.topAnchor.constraint(equalTo: topAnchor, constant: yOffset)
                ])
            }
        }
    }
    
//    override func layoutSubviews() {
//        backgroundColor = .white
//        super.layoutSubviews()
//        guard let fieldSize = dataSource?.size,
//            let cells = subviews as? [CellView] else { return }
//
//        let dimension = min(bounds.width, bounds.height) / CGFloat(fieldSize.width) // вычисляем минимум из длины и ширины и делаим на количество ячеек в строке,  получаем ширину ячейки
//
//        let cellSize = CGSize(width: Int(dimension), height: Int(dimension))
//
//        let diff = abs(bounds.width - bounds.height) / 2 // вычисляем пустую зону
//
//        var movX: CGFloat = 0
//        var movY: CGFloat = 0
//
//        if bounds.width > bounds.height {
//            movX = diff
//        } else {
//            movY = diff
//        }
//
//        for cell in cells {
//            cell.frame.size = cellSize
//            cell.frame.origin = CGPoint(x: movX + CGFloat(cell.point.x) * dimension,
//                                        y: movY + CGFloat(cell.point.y) * dimension)
//        }
//
//    }
//
//    private func setupVeiew() {
//        subviews.forEach{ subview in
//            subview.removeFromSuperview() }
//
//        guard let fieldSize = dataSource?.size else { return }
//        for x in 0..<fieldSize.width {
//            for y in 0..<fieldSize.height {
//                let cell = CellView(point: Point(x: x, y: y))
//                cell.addTarget(self, action: #selector(cellTuchUpInside), for: .touchUpInside)
//                addSubview(cell)
//            }
//        }
//    }
//
    func reloadData() {
        if dataSource?.size.area != subviews.count {
            for subview in subviews {
                subview.removeFromSuperview()
            }
            constraints.forEach(removeConstraint)
        }
        guard let dataSource = dataSource,
            let cells = subviews as? [CellView] else { return }

        for cell in cells {
            cell.cellType = dataSource.getCellTypeAtCoordinates(cell.point)
        }
    }
//
//    @objc private func cellTuchUpInside(cell: CellView) {
//        delegate?.didSelectCellAtPoint(point: cell.point)
//    }
//
}
