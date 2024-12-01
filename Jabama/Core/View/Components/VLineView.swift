//
//  VLineView.swift
//  Ludo
//
//  Created by Mohsen on 7/5/24.
//

import SwiftUI

struct VLineView: View {
    var color:Color = .gray
    var body: some View {
        Rectangle()
            .frame(width: 1)
            .foregroundStyle(color)
    }
}

#Preview {
    VLineView()
}

