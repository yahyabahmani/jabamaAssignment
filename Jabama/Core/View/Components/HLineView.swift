//
//  Line.swift
//  Ludo
//
//  Created by Mohsen on 7/5/24.
//

import SwiftUI

struct HLineView: View {
    var color:Color = .gray
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(color)
    }
}

#Preview {
    HLineView()
}
