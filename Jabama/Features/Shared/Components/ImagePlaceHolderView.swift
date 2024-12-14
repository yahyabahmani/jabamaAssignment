//
//  ImagePlaceHolderView.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import SwiftUI

struct ImagePlaceHolderView: View {
    var width: CGFloat = 100
    var height: CGFloat = 100
    var body: some View {
        Rectangle()
            .foregroundColor(.gray)
            .frame(height:width)
            .frame(width:height)
            .overlay{
                ProgressView()
                    .tint(.white)
            }
    }
}

#Preview {
    ImagePlaceHolderView()
}
