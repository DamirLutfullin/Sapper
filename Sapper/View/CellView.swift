//
//  CellView.swift
//  Sapper
//
//  Created by Damir Lutfullin on 05.07.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

class CellView: UIView {
    
    private(set) var point: Point
    private let label = UILabel()
    private lazy var titleLayer = CAShapeLayer()
    
    var cellType: CellType = .closed {
        didSet {
            let title: String
            let color: UIColor
            switch cellType {
            case .closed:
                title = ""
                color = .white
            case .flagged:
                title = "🚩"
                color = .white
            case .bombed:
                title = "💣"
                color = .red
            case .isEmpty:
                title = ""
                color = UIColor(white: 0.85, alpha: 1)
            case .label(value: let value):
                title = String(value)
                label.textColor = colorForValue(value)
                color = UIColor(white: 0.85, alpha: 1)
            }
            label.text = title
            titleColor = color
        }
    }
    
    var titleColor: UIColor = .white {
        didSet{
            titleLayer.fillColor = titleColor.cgColor
        }
    }
    
    init(point: Point) {
        self.point = point
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        layer.addSublayer(titleLayer)
        
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textColor = .black
        label.textAlignment = .center
        
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let offset: CGFloat = 2
        let rect = CGRect(x: offset, y: offset,
                          width: bounds.width - offset * 2,
                          height: bounds.height - offset * 2)
        titleLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: offset).cgPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func colorForValue(_ value: Int) -> UIColor {
        switch value {
        case 1:
            return .blue
        case 2:
            return UIColor(red: 0, green: 124/255, blue: 21/255, alpha: 1)
        case 3:
            return .red
        case 4:
            return UIColor(red: 15/255, green: 0, blue: 120/255, alpha: 1)
        case 5:
            return .blue
        case 6:
            return .systemBlue
        case 7:
            return .systemPink
        case 8:
            return .systemGray
        default:
            return .white
        }
    }
}
