//
//  Row.swift
//  Tracka
//
//  Created by yeni on 10/1/24.
//

import SwiftUI

struct TodayViewListRow: View {
    
    @State var medication: PrimaryMedication
    var isLastRow: Bool
    
    var body: some View{
        VStack(alignment: .center, spacing: 0){
            // Row
            ZStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 80)
                
                // Row Content
                HStack(alignment: .center){
                    Image("PillGreen")
                    VStack(alignment: .leading){
                        Text(medication.name + " " + "\(medication.strength)" + medication.unit)
                            .font(.title3)
                            .foregroundColor(.descriptionBlack)
                        Text("아직 복용하지 않음")
                        .foregroundColor(.deactivatedGray)}
                    Spacer()}}
            
            if !isLastRow {
                RowDivider()
            }
        }
    }
}
