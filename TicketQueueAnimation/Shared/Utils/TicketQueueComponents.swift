//
//  AppComponent.swift
//  TicketQueueAnimation
//
//  Created by Kosal Pen on 16/12/24.
//

import UIKit

enum TicketQueueComponents {
    
    struct AppColor {
        static let primary = UIColor.systemBlue
    }
    
    struct Gradient {
        
        static var colors = [
            "#5788FF".color,
            "#345299".color
        ]
        
        static let position = [
            CGPoint(x: 0.25, y: 0.5),
            CGPoint(x: 0.75, y: 0.5)
        ]
    }
}
