//
//  RowDivider.swift
//  Apillog
//
//  Created by yeni on 10/4/24.
//

import SwiftUI

struct RowDivider: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(
                x: 65,
                y: 0))
            path.addLine(to: CGPoint(
                x: UIScreen.main.bounds.width,
                y: 0))}
        .stroke(Color.rowDividerGray, lineWidth: 0.5)}
}
