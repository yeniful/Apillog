//
//  TodayView.swift
//  Tracka
//
//  Created by yeni on 9/27/24.
//

import SwiftUI
import SwiftData

struct TodayView: View {
<<<<<<< HEAD
    private var tempPillItems = [1, 2, 3]
=======
    
    @Environment(\.modelContext) private var modelContext
    
    private var medications: [PrimaryMedication] {
        if selectedPart == "아침" {
            return morningMedications
        } else if selectedPart == "점심" {
            return lunchMedications
        } else if selectedPart == "저녁" {
            return dinnerMedication
        } else {
            return allyMedications
        }
    }
    
    @Query(filter: #Predicate<PrimaryMedication> { medication in
        medication.isActive == true
    }) var allyMedications: [PrimaryMedication]
    @Query(filter: #Predicate<PrimaryMedication> { medication in
        medication.cycle != 2 && medication.cycle != 4 && medication.cycle != 6 && medication.isActive == true
    }) var morningMedications: [PrimaryMedication]
    @Query(filter: #Predicate<PrimaryMedication> { medication in
        medication.cycle != 1 && medication.cycle != 4 && medication.cycle != 5 && medication.isActive == true
    }) var lunchMedications: [PrimaryMedication]
    @Query(filter: #Predicate<PrimaryMedication> { medication in
        medication.cycle >= 4 && medication.isActive == true
    }) var dinnerMedication: [PrimaryMedication]
>>>>>>> d22120a (Feat: Categorized each PrimaryMedication based on partOfDay and display them in time section on the TodayView based on isActive)
    
    // Header
    @State private var currentDate = ""
    // Segmented Picker
    @State var selectedPart: String = ""
    var partsOfTheDay = ["아침", "점심", "저녁", "전체"]
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading, spacing: 0){
                    VStack(alignment: .leading){
                        
                        // MARK: Header
                        HStack{
                            Button("Data 확인"){
                                print("아침: \(morningMedications.count)")
                                print("점심: \(lunchMedications.count)")
                                print("저녁: \(dinnerMedication.count)")
                                print("전체: \(medications.count)")
                                print("==============================")
                            }
                            Text(currentDate)
                                .font(.title.bold())
                                .onAppear {
                                    selectedPart = getPartOfTheDay()
                                    updateTime()
                                    Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) {_ in
                                        updateTime()
                                    }}
                            Spacer()
                            Image(systemName: "calendar")
                                .foregroundColor(.primaryGreen)
                            .frame(width: 32, height: 32)}
                        .padding(.top, 16)
                        
                        // MARK: - Segmented Control Picker
                        Picker("", selection: $selectedPart) {
                            ForEach(partsOfTheDay, id: \.self) {
                                Text($0)}}
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(height: 48)
                        .controlSize(.extraLarge)
                        
                        // MARK: PrimaryPill
                        HStack{
                            Text(selectedPart + "약").font(.title2.bold())
                            Spacer()
                            
                            // Button To AddingMedicationView
                            NavigationLink(destination: PrimaryMedicationListView(isPresenting: false, isPresentedAddPrimaryMedicationView: false)){
                                Image("AddingMedicationButton")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)}}
                        
                        VStack(spacing: -10){
<<<<<<< HEAD
                            ForEach(tempPillItems, id: \.self) { item in
                                    TodayViewListRow(isLastRow: tempPillItems.last == item ? true : false)}}}
                    .padding(.horizontal, 16)
=======
                            ForEach(medications , id: \.self) { medication in
                                TodayViewListRow(medication: medication, isLastRow: medications.last == medication ? true : false)}}
                        
                    }.padding(.horizontal, 16)
>>>>>>> d22120a (Feat: Categorized each PrimaryMedication based on partOfDay and display them in time section on the TodayView based on isActive)
                    
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
                                    .foregroundStyle(.white)
                            }
                        }).trackaButtonStyle()
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
                        TodayViewListRow(isLastRow: true)}
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
    
    private func getPartOfTheDay() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "HH"
//        let hour = Int(formatter.string(from: Date()))!
        guard let hour = Int(formatter.string(from: Date())) else {
                return "Error"
            }
        
        if hour < 12 {
            return "아침"
        } else if hour < 18 {
            return "점심"
        } else if hour < 24 {
            return "저녁"
        }
        return "Error"
    }
}
