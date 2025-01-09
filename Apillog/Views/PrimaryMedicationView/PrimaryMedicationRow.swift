//
//  PrimaryMedicationRow.swift
//  Apillog
//
//  Created by yeni on 10/10/24.
//

import SwiftUI

struct PrimaryMedicationRow: View {
    
    @Environment(\.modelContext) private var modelContext
<<<<<<< HEAD
    @State var isActive: Bool = false
=======
>>>>>>> d22120a (Feat: Categorized each PrimaryMedication based on partOfDay and display them in time section on the TodayView based on isActive)
    var medication: PrimaryMedication
    @State var isActive: Bool
    
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
            
            Toggle(isOn: $isActive, label:{
                
            }).onChange(of: isActive) { oldValue, newValue in
                isActive = newValue
                medication.isActive = newValue
            }
        }
    }
}
