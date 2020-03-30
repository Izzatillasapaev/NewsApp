//
//  Date+.swift
//  AKV
//
//  Created by Izzatilla on 08.11.2019.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

extension Date {
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    func toString(with format: String = "dd.MM.yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
//        formatter.locale = Locale(identifier: "ru")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    func timeIn24HourFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
//        formatter.locale = Locale(identifier: "ru")
        return formatter.string(from: self)
    }
}
