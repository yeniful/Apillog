//
//  Cycle.swift
//  Apillog
//
//  Created by yeni on 10/10/24.
//

import Foundation

enum Cycle: Int, CustomStringConvertible {
    case morning = 1
    case lunch = 2
    case morningLunch = 3
    case morningDinner = 5
    case lunchDinner = 6
    case morningLunchDinner = 7
    
    var description: String {
        switch self {
        case .morning:
            return "아침"
        case .lunch:
            return "점심"
        case .morningLunch:
            return "아침 점심"
        case .morningDinner:
            return "아침 저녁"
        case .lunchDinner:
            return "점심 저녁"
        case .morningLunchDinner:
            return "아침 점심 저녁"
        }
    }
}
