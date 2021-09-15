//
//  ProductInfoViewController.swift
//  MindfulBeauty
//
//  Created by Ritu K on 4/18/19.
//  Copyright © 2019 Ritu K. All rights reserved.
//

import Foundation
import UIKit

class ProductInfoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let barcodeNumber = ProductData.defaults.string(forKey: "barcodeNumber") {
            
            if barcodeNumber == "0012044037539" {
                productName.text = "Old Spice Red Zone Deodorant Solid Swagger"
                productImage.image = UIImage(named: "OldSpice")
                crueltyFree.text = "This company is not cruelty free."
                harmfulIng.text = "Potentially harmful ingredients:\n Propylene Glycol (medium hazard)\n Tetrasodium EDTA (low hazard)"
                allergens.text = "Possible allergens:\n Fragrance"
            }
            
            if barcodeNumber == "0012044015605" {
                productName.text = "Old Spice Fresh Collection Antiperspirant & Deodorant Invisible Solid Fiji"
                productImage.image = UIImage(named: "Fiji")
                crueltyFree.text = "This company is cruelty free!"
                harmfulIng.text = "Potentially harmful ingredients:\n Guar Gum (Low hazard)"
                allergens.text = "Possible allergens:\n Fragrance"
            }
            
            if barcodeNumber == "0609332850231" {
                productName.text = "E.l.f. Studio Makeup Mist & Set"
                productImage.image = UIImage(named: "Elf")
                crueltyFree.text = "This company is cruelty free!"
                harmfulIng.text = "Potentially harmful ingredients:\n Propylene Glycol(Medium Hazard)\n Phenoxyethanol (Medium hazard)\n Methylparaben (Low Hazard)\n Ethyl Paraben (Low Hazard)\n Butyl Paraben (Low Hazard)\n Propylparaben (Low Hazard)\n Isobutylparaben (Low Hazard)"
                allergens.text = "No potential allergens."
            }
            
            if barcodeNumber == "0071249017296" {
                productName.text = "L'Oreal Paris True Match - Light/Medium Warm"
                productImage.image = UIImage(named: "Loreal")
                crueltyFree.text = "This company is not cruelty free."
                harmfulIng.text = "Potentially harmful ingredients:\n Propylene Glycol (Medium hazard)\n Phenoxyethanol (Medium Hazard)\n Methylparaben (Low Hazard)\n Butyl Paraben (Low Hazard)\n Aluminum Oxide (Low Hazard)\n Mica (Low Hazard)"
                allergens.text = "No potential allergens."
            }
        }
    }
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var crueltyFree: UILabel!
    
    @IBOutlet weak var harmfulIng: UILabel!
    
    @IBOutlet weak var allergens: UILabel!
    
    
}
