//
//  PrimaryMedicationView.swift
//  Apillog
//
//  Created by yeni on 10/4/24.
//

import SwiftUI
import SwiftData

struct PrimaryMedicationView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var primaryMedications: [PrimaryMedication]
    @State private var selectedMedication: PrimaryMedication?
    
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
            ForEach(primaryMedications) { item in
                Button(item.name) {
                    selectedMedication = item}}
            .onDelete(perform: deleteMedication)
            .sheet(item: $selectedMedication) { item in
                VStack {
                    Text(item.name)
                        .font(.title)
                    Text("Strength: \(item.strength)\(item.unit)")
                    Text("Cycle: \(item.cycle) days")
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
                    EditButton()}
#endif
                ToolbarItem {
                    Button(action: addMedication) {
                        Label("Add Item", systemImage: "plus")}}}
    }
    
    // MARK: - Default Swift Data Functions
    private func addMedication() {
        withAnimation {
            let newItem = PrimaryMedication(
                name: "test \(Date())",
                strength: 10,
                unit: "mg",
                cycle: 1,
                durationStartDate: Date(),
                durationEndDate: Date())
            modelContext.insert(newItem)}
    }
    
    private func deleteMedication(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(primaryMedications[index])}}
    }
    
}
