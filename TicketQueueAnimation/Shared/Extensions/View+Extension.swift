//
//  View+Extension.swift
//  TicketQueueAnimation
//
//  Created by Kosal Pen on 16/12/24.
//

import UIKit

extension UIView {
    
    enum GradientType {
        case vertical
        case horizontal
    }
    
    @discardableResult
    func applySmartGradientTranslucency(
        type: GradientType = .vertical,
        colors: [UIColor] = [UIColor(hexString: "00853E"), UIColor(hexString: "00A950") ]
    ) -> Self {
        let backgroundView = GradientView(gradientStartColor: colors[1], gradientEndColor: colors[0], type: type)
        insertSubview(backgroundView, at: 0)
        backgroundView.anchor(in: self)
            .translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

private class GradientView: UIView {
    
    private let gradient : CAGradientLayer = CAGradientLayer()
    private let gradientStartColor: UIColor
    private let gradientEndColor: UIColor
    private let type: GradientType

    init(gradientStartColor: UIColor, gradientEndColor: UIColor, type: GradientType = .vertical) {
        self.gradientStartColor = gradientStartColor
        self.gradientEndColor = gradientEndColor
        self.type = type
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = self.bounds
    }

    override public func draw(_ rect: CGRect) {
        gradient.frame = self.bounds
        gradient.colors = [gradientEndColor.cgColor, gradientStartColor.cgColor]
        if case .horizontal = type {
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        if gradient.superlayer == nil {
            layer.insertSublayer(gradient, at: 0)
        }
    }
}
