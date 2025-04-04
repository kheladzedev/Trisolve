//
//  IsometricTileView.swift
//  TriSolve
//
//  Created by Edward on 03.04.2025.
//

import UIKit

class IsometricTileView: UIView {

    private let shapeLayer = CAShapeLayer()
    private let triangleLayer = CAShapeLayer()

    var type: TileType = .empty {
        didSet {
            updateAppearance()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        layer.addSublayer(shapeLayer)
        layer.addSublayer(triangleLayer)
        backgroundColor = .clear
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        drawIsometricDiamond()
        drawTriangleIfNeeded()
    }

    private func drawIsometricDiamond() {
        let path = UIBezierPath()
        let w = bounds.width
        let h = bounds.height

        path.move(to: CGPoint(x: w / 2, y: 0))
        path.addLine(to: CGPoint(x: w, y: h / 2))
        path.addLine(to: CGPoint(x: w / 2, y: h))
        path.addLine(to: CGPoint(x: 0, y: h / 2))
        path.close()

        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 1
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.darkGray.cgColor
    }

    private func drawTriangleIfNeeded() {
        triangleLayer.path = nil
        triangleLayer.fillColor = nil

        guard type == .triangleLeft || type == .triangleRight else { return }

        let w = bounds.width
        let h = bounds.height
        let trianglePath = UIBezierPath()

        if type == .triangleLeft {
            trianglePath.move(to: CGPoint(x: w / 2, y: h / 2))
            trianglePath.addLine(to: CGPoint(x: 0, y: h / 4))
            trianglePath.addLine(to: CGPoint(x: 0, y: 3 * h / 4))
        } else {
            trianglePath.move(to: CGPoint(x: w / 2, y: h / 2))
            trianglePath.addLine(to: CGPoint(x: w, y: h / 4))
            trianglePath.addLine(to: CGPoint(x: w, y: 3 * h / 4))
        }

        trianglePath.close()
        triangleLayer.path = trianglePath.cgPath
        triangleLayer.fillColor = UIColor.systemYellow.cgColor
    }

    private func updateAppearance() {
        switch type {
        case .empty:
            shapeLayer.fillColor = UIColor.darkGray.cgColor
        case .start:
            shapeLayer.fillColor = UIColor.systemGreen.cgColor
        case .goal:
            shapeLayer.fillColor = UIColor.systemRed.cgColor
        case .triangleLeft, .triangleRight:
            shapeLayer.fillColor = UIColor.darkGray.cgColor
        }
    }
}

