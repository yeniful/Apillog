//
//  PrimaryMedicationRow.swift
//  Apillog
//
//  Created by yeni on 10/10/24.
//

import SwiftUI

struct PrimaryMedicationRow: View {
    
    @Environment(\.modelContext) private var modelContext
    var medication: PrimaryMedication
    @State var isActive: Bool
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                if let cycle = Cycle(rawValue: medication.cycle) {
                    Text("\(cycle.description)").foregroundStyle(.gray)
                } else {
                    Text("Error")
//                        .foregroundStyle(.apillogGrayActivated)
                }
                Text(medication.name)
//                    .foregroundStyle(.apillogBlackDescription)
            }
            
            Spacer()
            
            Toggle(isOn: $isActive, label:{
                
            }).onChange(of: isActive) { oldValue, newValue in
                isActive = newValue
                medication.isActive = newValue
            }
        }
    }
}
