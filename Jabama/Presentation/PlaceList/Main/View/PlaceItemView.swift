//
//  PlaceItemView.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct PlaceItemView: View {
    var searchPlace:SearchPlace
    var body: some View {
        VStack {
            HStack{
                WebImage(url: URL(string: ExtractPhotoUtil.getImageUrl(from: searchPlace.firstPhoto(),width: 100,height:100))) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height:100)
                        .frame(width:100)
                    
                } placeholder: {
                    ImagePlaceHolderView()
                }
                .frame(height:100)
                .frame(width:100)
                .clipShape(Circle())
                
                VStack(alignment:.leading,spacing:8){
                    Text(searchPlace.name?.getEnglishAlphabet() ?? "")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .padding(.trailing,52)
                    
                    Text(searchPlace.name?.getPersianAlphabet() ?? "")
                        .font(.kBody)
                        .foregroundColor(.mediumGray)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    HStack{
                        Text(searchPlace.firstCategory()?.shortName ?? "")
                            .font(.kBody)
                            .foregroundColor(.mediumGray)
                            .lineLimit(1)
                            .multilineTextAlignment(.leading)
                        
                        ScoreView(score: searchPlace.score())
                    }
                    
                    Text(searchPlace.distanceInKm())
                        .font(.kBody)
                        .foregroundColor(.mediumGray)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                    
                    Text(searchPlace.location?.address ?? "")
                        .font(.kBody)
                        .foregroundColor(.mediumGray)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    
                }
                
                Spacer()
                
            }.frame(width: getRect().size.width-32)
            
            Text(searchPlace.lastTip())
                .font(.kBody)
                .foregroundColor(.mediumGray)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
        }
        .overlay(alignment:.topTrailing){
            RatingView(rating: searchPlace.rating ?? 0.0)
        }
        .padding(8)
        .background(.white)
        .cornerRadius(5)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    PlaceListMainView()
}
