//
//  Item.swift
//  Apillog
//
//  Created by yeni on 9/25/24.
//

import Foundation
import SwiftData

@Model
final class PrimaryMedication {
    var id: UUID
    var name: String
    var strength: Int
    var unit: String
    var cycle: Int
    var durationStartDate: Date
    var durationEndDate: Date
    var creadtedTime: Date
    var isArchived: Bool

    init(name: String, strength: Int, unit: String, cycle: Int, durationStartDate: Date, durationEndDate: Date){
        self.id = UUID()
        self.name = name
        self.strength = strength
        self.unit = unit
        self.cycle = cycle
        self.durationStartDate = durationStartDate
        self.durationEndDate = durationEndDate
        self.creadtedTime = Date()
        self.isArchived = false
    }
}
