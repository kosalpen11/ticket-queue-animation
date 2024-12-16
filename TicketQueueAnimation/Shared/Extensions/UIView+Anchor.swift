//
//  UIView+Anchor.swift
//  UIComponents
//
//  Created by Kosal Pen on 8/4/24.
//

import UIKit

public enum AnchorEdge {
    case left(CGFloat)
    case right(CGFloat)
    case top(CGFloat)
    case bottom(CGFloat)
}

public extension UIView {
    
    @discardableResult
    func anchor(in view: UIView, gap: CGFloat = 0) -> Self {
        return anchor(in: view, at: .left(gap), .right(gap), .top(gap), .bottom(gap))
    }
    
    @discardableResult
    func anchor(in view: UIView, at edges: AnchorEdge...) -> Self {
        
        edges.forEach {
            switch $0 {
            case .left(let gap): leftAnchor.constraint(equalTo: view.leftAnchor, constant: gap).isActive = true
            case .right(let gap): rightAnchor.constraint(equalTo: view.rightAnchor, constant: -gap).isActive = true
            case .top(let gap): topAnchor.constraint(equalTo: view.topAnchor, constant: gap).isActive = true
            case .bottom(let gap): bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -gap).isActive = true
            }
        }
        return self
    }
    
    @discardableResult
    func anchor(in layoutGuide: UILayoutGuide, gap: CGFloat = 0) -> Self {
        return anchor(in: layoutGuide, at: .left(gap), .right(gap), .top(gap), .bottom(gap))
    }
    
    @discardableResult
    func anchor(in layoutGuide: UILayoutGuide, at edges: AnchorEdge...) -> Self {
        edges.forEach {
            switch $0 {
            case .left(let gap): leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: gap).isActive = true
            case .right(let gap): rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -gap).isActive = true
            case .top(let gap): topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: gap).isActive = true
            case .bottom(let gap): bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -gap).isActive = true
            }
        }
        return self
    }
    
    @discardableResult
    func anchor(leftTo _leftAnchor: NSLayoutXAxisAnchor? = nil,
                rightTo _rightAnchor: NSLayoutXAxisAnchor? = nil,
                topTo _topAnchor: NSLayoutYAxisAnchor? = nil,
                bottomTo _bottomAnchor: NSLayoutYAxisAnchor? = nil,
                gaps: UIEdgeInsets = .zero) -> Self {
        
        _leftAnchor?.constraint(equalTo: leftAnchor, constant: -gaps.left).isActive = true
        _rightAnchor?.constraint(equalTo: rightAnchor, constant: -gaps.right).isActive = true
        _topAnchor?.constraint(equalTo: topAnchor, constant: -gaps.top).isActive = true
        _bottomAnchor?.constraint(equalTo: bottomAnchor, constant: -gaps.bottom).isActive = true
        return self
    }
    
    @discardableResult
    func anchor(centerXTo _centerXAnchor: NSLayoutXAxisAnchor? = nil,
                centerYTo _centerYAnchor: NSLayoutYAxisAnchor? = nil,
                offset: CGSize = .zero) -> Self {
        
        _centerXAnchor?.constraint(equalTo: centerXAnchor, constant: -offset.width).isActive = true
        _centerYAnchor?.constraint(equalTo: centerYAnchor, constant: -offset.height).isActive = true
        return self
    }
    
    @discardableResult
    func anchor(widthTo width: CGFloat? = nil, heightTo height: CGFloat? = nil) -> Self {
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        return self
    }
    
    @discardableResult
    func anchor(ratioTo ratio: CGFloat) -> Self {
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: ratio).isActive = true
        return self
    }
}

public extension UIView {
    func constraint(byIdentifier identifier: String) -> NSLayoutConstraint? {
        return constraints.first(where: { $0.identifier == identifier })
    }
}
