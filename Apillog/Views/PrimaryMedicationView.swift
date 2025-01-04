//
//  PrimaryMedicationView.swift
//  Tracka
//
//  Created by yeni on 10/4/24.
//

import SwiftUI
import SwiftData

struct PrimaryMedicationView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var primaryMedications: [PrimaryMedication]
    
    
    var body: some View {
        // MARK: - Default Swift Data
            List {
                ForEach(primaryMedications) { item in
                    NavigationLink {
                        Text(item.name)
                    }
                    label: {
//                        Text(item.durationStartDate, format: Date.FormatStyle(
//                            date: .numeric,
//                            time: .standard))
                        Text(item.id.uuidString)
                    }
                }
                .onDelete(perform: deleteMedication)}
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
                        Label("Add Item", systemImage: "plus")}}}}
    
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

#Preview {
    PrimaryMedicationView()
}
