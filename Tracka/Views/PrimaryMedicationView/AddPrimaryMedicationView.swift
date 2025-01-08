//
//  AddPrimaryMedicationView.swift
//  Apillog
//
//  Created by yeni on 10/9/24.
//

import SwiftUI

struct AddPrimaryMedicationView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented: Bool
    @State var medicationName: String = ""
    @State var strength: Int = 0
    @State var unit: String = ""
    @State var cycle: Int = 0
    @State var durationStartDate: Date?
    @State var durationEndDate: Date?
    @State var isNameEditable: Bool = false
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    // TODO: Apply once the design is decided
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("약 이름")
                
                Picker("약을 골라주세요.", selection: $medicationName){
                    ForEach(["콘서타", "메디키넷", "직접 입력"], id: \.self){ name in
                        Text(name)
                    }
                }.pickerStyle(.segmented)
                    .onChange(of: medicationName) { oldName, newName in
                        isNameEditable = (medicationName != "콘서타" && medicationName != "메디키넷")
                        if isNameEditable {
                            medicationName = newName
                        }
                    }
                if isNameEditable {
                    TextField("약 이름을 입력해주세요", text: $medicationName).disableAutocorrection(true)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Text("용량")
                HStack{
                    TextField("약 용량을 입력해주세요", value: $strength, formatter: formatter).disableAutocorrection(true)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Picker("약 용량 단위", selection: $unit){
                        ForEach(["mg", "정"], id: \.self){ unit in
                            Text(unit)
                        }}}.pickerStyle(.segmented)
                Text("복용 시간대")
                HStack{
                    // TODO: develop the cycle calculation logic
                    Button("아침"){
                        cycle += (cycle == 0 || cycle == 2 || cycle == 6 ? 1 : -1)
                        NSLog("\(cycle)")
                    }
                    .buttonStyle(.borderedProminent)
                    .accentColor(cycle % 2 != 0 ? .green : .gray)
                    Button("점심"){
                        cycle += (cycle == 0 ||  cycle == 1 ? 2 : -2)
                        NSLog("\(cycle)")
                    }
                    .buttonStyle(.borderedProminent)
                    .accentColor(cycle == 2 || cycle == 3 || cycle == 6 || cycle == 7 ? .green : .gray)
                    Button("저녁"){
                        cycle +=  (cycle < 4 ? 4 : -4)
                        NSLog("\(cycle)")
                    }
                    .buttonStyle(.borderedProminent)
                    .accentColor( cycle >= 4 ? .green : .gray)
                }
                Spacer()
            }
            
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        isPresented = false }
                    .foregroundStyle(.apillogGreen)}
#endif
                ToolbarItem {
                    Button("저장") {
                        addMedication(
                            name: medicationName,
                            strength: strength,
                            unit: unit, cycle: cycle,
                            durationStartDate: durationStartDate,
                            durationEndDate: durationEndDate)
                        
                        isPresented = false }
                    .foregroundStyle(.apillogGreen)}
            }
        }.padding([.horizontal, .top], 16)
    }
    
    // MARK: - Default Swift Data Functions
    private func addMedication(
        name: String,
        strength: Int,
        unit: String,
        cycle: Int,
        durationStartDate: Date?,
        durationEndDate: Date?) {
            withAnimation {
                let newItem = PrimaryMedication(
                    name: name,
                    strength: strength,
                    unit: unit,
                    cycle: cycle,
                    durationStartDate: Date(),
                    durationEndDate: Date())
                modelContext.insert(newItem)}
        }
    
}
