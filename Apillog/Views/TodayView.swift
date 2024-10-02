//
//  TodayView.swift
//  Apillog
//
//  Created by yeni on 9/27/24.
//

import SwiftUI
import SwiftData

struct TodayView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    private var tempPillItems = [1, 2, 3]
    
    // Header
    @State private var currentDate = ""
    
    // Segmented Picker
    @State var selectedParts = "전체"
    var partsOfTheDay = ["전체", "아침", "점심", "저녁"]
    
    @State private var selectedSegment = 0
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 0){
                VStack(alignment: .leading){
                    
                    // Header
                    HStack{
                        Text(currentDate)
                            .font(.title.bold())
                            .onAppear {
                                updateTime()
                                Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) {_ in
                                    updateTime()}}
                        Spacer()
                        Image(systemName: "calendar")
                            .foregroundColor(.primaryGreen)
//                            .foregroundStyle(.green)
                        .frame(width: 32, height: 32)}
                    .padding(.top, 16)
                    
                    
                    // Segmented Control Picker
                    Picker("", selection: $selectedParts) {
                        ForEach(partsOfTheDay, id: \.self) {
                            Text($0)}}
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(height: 48)
                    .controlSize(.extraLarge)
                    
                    // Header
                    Text("아침약").font(.title2.bold())
                    
                    VStack(spacing: -10){
                        ForEach(tempPillItems, id: \.self) { item in
                            NavigationLink {
                                // Row Destination
                            } label: {
                                Row()}}}
                }.padding(.horizontal, 16)
                
                Button(action: {
                    NSLog("test")}){
                        // Button UI
                        ZStack{
                            Rectangle()
                                .foregroundColor(.primaryGreen)
                                .frame(height: 63)
                            Text("모두 복용하기")
                                .font(.title2.bold())
                            .foregroundStyle(.white)}}
                    .padding(.top, -10)
                
                // 추가약
                VStack(alignment: .leading){
                    Text("추가기록").font(.title2.bold())
                    Row()}
                .padding(.horizontal, 16)
                .padding(.top, 24)
                
                // MARK: - Default Swift Data
                NavigationSplitView {
                    List {
                        ForEach(items) { item in
                            NavigationLink {
                                Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")}
                            label: {
                                Text(item.timestamp, format: Date.FormatStyle(
                                    date: .numeric,
                                    time: .standard))}}
                        .onDelete(perform: deleteItems)}
#if os(macOS)
                    .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
                    .toolbar {
#if os(iOS)
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()}
#endif
                        ToolbarItem {
                            Button(action: addItem) {
                                Label("Add Item", systemImage: "plus")}}}}
                detail: {
                    Text("Select an item")}}}
    }
    
    // MARK: - Default Swift Data Functions
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)}
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])}}
    }
    
    // Functions
    private func updateTime() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
//        formatter.dateStyle = ""
        formatter.dateFormat = "M월 d일 EEEE"
        currentDate = formatter.string(from: Date())
    }
}

#Preview {
    TodayView().modelContainer(for: Item.self, inMemory: true)
}
