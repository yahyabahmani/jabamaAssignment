//
//  Error+Ext.swift
//  Ludo
//
//  Created by Mohsen on 7/14/24.
//

import Foundation
extension Error{
    func toModel()->ErrorModel{
        if self is ErrorModel{
            return self as! ErrorModel
        }else{
            return ErrorModel(code: 400 ,message: self.localizedDescription)
        }
    }
}
