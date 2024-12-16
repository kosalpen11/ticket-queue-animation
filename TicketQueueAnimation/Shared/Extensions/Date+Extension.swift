//
//  Date+Extension.swift
//  TicketQueueAnimation
//
//  Created by Kosal Pen on 16/12/24.
//

import Foundation

extension Date {
    
    func formatted(custom: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = custom
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
}
