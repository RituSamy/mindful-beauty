//
//  ProductInfo.swift
//  MindfulBeauty
//
//  Created by Ritu K on 4/18/19.
//  Copyright © 2019 Ritu K. All rights reserved.
//

import Foundation

class ProductInfo {
    var barcode: String = ""
    var productName: String = ""
    var brand: String = ""
    var manufacturer: String = ""
    var imageURL: String = ""
    
    func description() -> String {
        return "barcode number: \(barcode), product name: \(productName), brand: \(brand), manufacturer: \(manufacturer), imageURL: \(imageURL)"
    }
}
