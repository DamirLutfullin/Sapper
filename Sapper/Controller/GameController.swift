//
//  ViewController.swift
//  Sapper
//
//  Created by Damir Lutfullin on 03.07.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    var gameFieldView = GameFieldView()
    let gameModel = GameModel()
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.addSubview(gameFieldView)
        gameFieldView.dataSource = self
        scrollView.delegate = self
        scrollView.backgroundColor = .systemGray5
        
        view.layoutSubviews()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGusture))
        gameFieldView.addGestureRecognizer(recognizer)
    }
    
    @objc func handleTapGusture(_ recodnizer: UITapGestureRecognizer) {
        let location = recodnizer.location(in: gameFieldView)
        
        if scrollView.zoomScale < 1 {
            scrollView.zoomTo(location: location)
        } else {
            let size = gameFieldView.size
            let point = Point(x: Int(location.x / size),
                              y: Int(location.y / size))
            
            didSelectCellAtPoint(point: point)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        view.layoutIfNeeded()
        zoomOut()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateInsets()
    }
    
    func zoomOut() {
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    @IBAction func startNewGame(_ sender: UIBarButtonItem) {
        gameModel.restart()
        gameFieldView.reloadData()
        UIView.animate(withDuration: 0.5, animations: zoomOut)
    }
    
    private func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / gameFieldView.bounds.width
        let heightScale = size.height / gameFieldView.bounds.height
        let minScale = min(heightScale, widthScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
    private func updateInsets() {
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
    }
}

extension GameController: GameFieldViewDataSource, GameFieldDelegate {
    
    var size: Size {
        return gameModel.configuration.size
    }
    
    func getCellTypeAtCoordinates(_ coordinates: Point) -> CellType {
        return gameModel.getCellTypeAtCoordinates(coordinates)
    }
    
    func didSelectCellAtPoint(point: Point) {
        gameModel.revealCellAtPoint(point: point)
        gameFieldView.reloadData()
    }
}

extension GameController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return gameFieldView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateInsets()
    }
    
}
