//
//  scrollView + extension.swift
//  Sapper
//
//  Created by Damir Lutfullin on 06.07.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func zoomTo(location: CGPoint) {
        let rect = zoomRectForScale(1, center: location)
        zoom(to: rect, animated: true)
    }
    
    func zoomRectForScale(_ scale: CGFloat, center: CGPoint)  -> CGRect {
        var rect = CGRect.zero
        rect.size.height = frame.size.height / scale
        rect.size.width = frame.size.width / scale
        
        rect.origin.x = center.x * (2 - minimumZoomScale) + (rect.size.width / 2)
        
        rect.origin.y = center.y * (2 - minimumZoomScale) + (rect.size.height / 2)
        return rect
    }
    
}
