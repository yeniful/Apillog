//
//  PrimaryMedicationRow.swift
//  Apillog
//
//  Created by yeni on 10/10/24.
//

import SwiftUI

struct PrimaryMedicationRow: View {
    
//    @Environment(\.modelContext) private var modelContext
    @State var isActive: Bool = false
    var medication: PrimaryMedication
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                if let cycle = Cycle(rawValue: medication.cycle) {
                    Text("\(cycle.description)").foregroundStyle(.apillogGrayActivated)
                } else {
                    Text("Error").foregroundStyle(.apillogGrayActivated)
                }
                Text(medication.name).foregroundStyle(.apillogBlackDescription)
            }
            
            Spacer()
            
            Toggle(isOn: $isActive, label: {
                
            })
        }
    }
}
