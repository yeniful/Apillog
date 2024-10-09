//
//  PrimaryMedicationView.swift
//  Apillog
//
//  Created by yeni on 10/4/24.
//

import SwiftUI
import SwiftData

struct PrimaryMedicationListView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var primaryMedications: [PrimaryMedication]
    @State private var selectedMedication: PrimaryMedication?
    @State var isPresenting: Bool = true
    @State var isPresentedAddPrimaryMedicationView: Bool
    
    // MARK: - DateFormatter
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M월 d일 EEEE"
        return formatter
    }
    
    var body: some View {
        // MARK: - Default Swift Data
        List {
            ForEach(primaryMedications, id: \.id) { item in
                
                Button(action: {
                    selectedMedication = item
                }, label: {
                    PrimaryMedicationRow(medication: item)
                })
            }
//            .onDelete(perform: deleteMedication)
            .sheet(item: $selectedMedication) { item in
                VStack {
                    Text(item.name)
                        .font(.title)
                    Text("Strength: \(item.strength)\(item.unit)")
                    if let cycle = Cycle(rawValue: item.cycle) {
                        Text("Cycle: \(cycle.description)")
                    } else {
                        Text("Error")
                    }
                    Text("복용 시작: \(dateFormatter.string(from: item.durationStartDate))")
                    Text("복용 끝: \(dateFormatter.string(from: item.durationEndDate))")
                }
                .padding()}}
#if os(macOS)
        .navigationSplitViewColumnWidth(min: 180, ideal: 200)
        
#endif
        .toolbar {
#if os(iOS)
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
#endif
            ToolbarItem {
                Button(action: {
                    isPresentedAddPrimaryMedicationView = true
                }) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentedAddPrimaryMedicationView){
            AddPrimaryMedicationView(
                isPresented: $isPresentedAddPrimaryMedicationView)}
    }
    
    private func deleteMedication(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(primaryMedications[index])}}
    }
}

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
