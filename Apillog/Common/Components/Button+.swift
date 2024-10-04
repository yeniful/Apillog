//
//  Button+.swift
//  Apillog
//
//  Created by yeni on 10/4/24.
//

import SwiftUI

extension Button {
    
    func apillogButtonStyle() -> some View { self
                .foregroundColor(Color.primaryGreen)
                .cornerRadius(30)
                .font(.title2.bold())
                .padding(.top, 16)
    }
}
