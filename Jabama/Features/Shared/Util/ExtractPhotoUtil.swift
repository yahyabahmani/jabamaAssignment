//
//  ExtractPhotoUtil.swift
//  Jabama
//
//  Created by Mohsen on 12/2/24.
//

struct ExtractPhotoUtil{
    static func getImageUrl(from photo: Photo? = nil , width:Int?=nil,height:Int?=nil) -> String {
        if let photo{
            if let width,let height{
                return (photo.prefix ?? "") + "\(width)x\(height)" + (photo.suffix ?? "")
             }
             return (photo.prefix ?? "")+"original" + (photo.suffix ?? "")
        }
        return ""
       
    }
    
    static func getIconUrl(from photo: Photo , size:Int) -> String {
        return (photo.prefix ?? "") + "\(size)" + (photo.suffix ?? "")
    }
}
