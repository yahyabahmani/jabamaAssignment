//
//  EmptyPlaceListItemView.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import SwiftUI

struct LoadingPlaceListItemView: View {
    var body: some View {
        VStack {
            HStack{
                Circle()
                    .fill(.gray)
                    .frame(height:100)
                    .frame(width:100)
                    .clipShape(Circle())
                
                VStack(alignment:.leading,spacing:8){
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.gray)
                        .frame(height:8)
                        .padding(.trailing,52)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.gray)
                        .frame(height:8)
                        .padding(.trailing,16)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.gray)
                        .frame(height:8)
                        .padding(.trailing,16)
                    
                }
                
                Spacer()
                
            }.frame(width: getRect().size.width-32)
            RoundedRectangle(cornerRadius: 4)
                .fill(.gray)
                .frame(height:8)
                .padding(.horizontal,16)
            
        }
        .shimmer(.init(tint: .gray.opacity(0.5), highlight: .white.opacity(0.5), blur: 10))
        .padding(8)
        .background(.white)
        .cornerRadius(5)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    LoadingPlaceListItemView()
}
