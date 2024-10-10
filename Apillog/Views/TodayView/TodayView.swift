//
//  TodayView.swift
//  Apillog
//
//  Created by yeni on 9/27/24.
//

import SwiftUI
import SwiftData

struct TodayView: View {
    
    private var tempPillItems = [1, 2, 3]
    @Environment(\.modelContext) private var modelContext
    @Query private var primaryMedications: [PrimaryMedication]
    
    // Header
    @State private var currentDate = ""
    
    // Segmented Picker
    @State var selectedParts = "전체"
    var partsOfTheDay = ["전체", "아침", "점심", "저녁"]
    
    @State private var selectedSegment = 0
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading, spacing: 0){
                    VStack(alignment: .leading){
                        
                        // MARK: Header
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
                            .frame(width: 32, height: 32)}
                        .padding(.top, 16)
                        
                        // MARK: - Segmented Control Picker
                        Picker("", selection: $selectedParts) {
                            ForEach(partsOfTheDay, id: \.self) {
                                Text($0)}}
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(height: 48)
                        .controlSize(.extraLarge)
                        
                        // MARK: PrimaryPill
                        HStack{
                            Text("아침약").font(.title2.bold())
                            Spacer()
                            NavigationLink(destination: PrimaryMedicationListView(isPresenting: false, isPresentedAddPrimaryMedicationView: false)){
                                Image("AddingMedicationButton")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 32, height: 32)}}
                        
                        VStack(spacing: -10){
                            
                            ForEach(primaryMedications , id: \.self) { medication in
                                TodayViewListRow(medication: medication, isLastRow: primaryMedications.last == medication ? true : false)}
                            
                        }}
                    .padding(.horizontal, 16)
                    
                    // MARK: 전체 섭취 Button
                    HStack{
                        Spacer()
                        Button(action: {
                            NSLog("test")
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 171, height: 60)
                                Text("모두 섭취하기")
                                    .foregroundStyle(.white)}})
                        .apillogButtonStyle()
                        Spacer()}
                    
                    ListDivider()
                        .padding(.top, 32)
                    
                    // MARK: SecondaryPill
                    VStack(alignment: .leading){
                        HStack{
                            Text("추가기록").font(.title2.bold())
                            Spacer()
                            // TODO: - SecondaryMedicationView로 수정
                            NavigationLink(destination: EmptyView()) {
                                Image("AddingMedicationButton")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)}}
                        // TODO: Secondary Medication List
//                        TodayViewListRow(medication: <#T##PrimaryMedication#>, isLastRow: <#T##Bool#>)
                    }
                    .padding([.horizontal, .top], 16)}}
            
        } // NavigationStack
        .accentColor(.primaryGreen)
    }
    
    // MARK: - Functions
    private func updateTime() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M월 d일 EEEE"
        currentDate = formatter.string(from: Date())
    }
}
