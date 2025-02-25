//
//  TrackaDivider.swift
//  Tracka
//
//  Created by yeni on 10/4/24.
//

import SwiftUI

struct ListDivider: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(
                x: 0,
                y: 0))
            path.addLine(to: CGPoint(
                x: UIScreen.main.bounds.width,
                y: 0))}
        .stroke(Color.listDividerGray, lineWidth: 8)}
}
