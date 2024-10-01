//
//  Row.swift
//  Apillog
//
//  Created by yeni on 10/1/24.
//

import SwiftUI

struct Row: View {
    var body: some View{
        VStack(alignment: .center, spacing: 0){
            // Row
            ZStack{
                Rectangle()
                    .foregroundColor(.clear)
                // Row UI 확인용
//                    .foregroundColor(.blue)
//                    .opacity(0.2)
                    .frame(height: 80)
                
                // Row Content
                HStack(alignment: .center){
                    Image("PillGreen")
                    VStack(alignment: .leading){
                        Text("콘서타" + " " + "36" + "mg")
                            .font(.title3)
                            .foregroundColor(.black)
                        Text("아직 복용하지 않음")
                        .foregroundColor(.gray)}
                    Spacer()}}
            
            Path { path in
                path.move(to: CGPoint(
                    x: 65,
                    y:0))
                path.addLine(to: CGPoint(
                    x: UIScreen.main.bounds.width,
                    y:0))}
            .stroke(Color.gray, lineWidth: 0.5)}
    }
}

#Preview {
    Row()
}
