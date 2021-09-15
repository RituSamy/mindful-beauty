//
//  ScannedProductInfoViewController.swift
//  MindfulBeauty
//
//  Created by Ritu K on 4/18/19.
//  Copyright © 2019 Ritu K. All rights reserved.
//

import Foundation
import UIKit

class ScannedProductInfoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //getProductInfo()
        
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
                crueltyFree.text = "This company is not cruelty free."
                harmfulIng.text = "Potentially harmful ingredients:\n Talc (Low hazard)"
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
    
    
    func getProductInfo() {
        if let barcode = ProductData.defaults.string(forKey: "barcodeNumber") {
            let url = "https://api.barcodelookup.com/v2/products?formatted=y&w3908154cubhrnheuj0ikcflukgivg&barcode=\(barcode)"
            
            makeNetworkCall(url: url, method: "GET", headers: nil, content: nil) { (data, urlResponse, error) in
                if let data = data {
                    // set the productName to the product name from the info.
                    ProductData.defaults.set(self.getProductInfo(data: data).productName, forKey: "product name")
                    print(self.getProductInfo(data: data).productName)
                }
            }
        }
    }
    
    func makeNetworkCall(url: String, method: String, headers: [String: String]?, content: Data?, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        // making sure that url is valid
        guard let url = URL(string: url) else {
            return
        }
        
        // URL means universal resource locator
        // creating a URLRequest: making a network request from a url
        var urlRequest = URLRequest(url: url)
        // method: get or post
        urlRequest.httpMethod = method
        // if you send data as part of the request (post)
        urlRequest.httpBody = content
        
        // if there are headers passed into the function, set the values in the dictionary to the url request
        if let headers = headers {
            for (k, v) in headers {
                urlRequest.addValue(v, forHTTPHeaderField: k)
            }
        }
        
        // create a task object for the system to do the work.
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: callback)
        //start the task, actually initiate the work
        task.resume()
    }
    
    func getProductInfo(data: Data) -> ProductInfo {
        // create a new instance of the ProductInfo class
        let productInfo = ProductInfo()
        
        do {
            // declare a json object as a dictionary of strings to any.
            // JSONSerialization is a helper class that helps to convert between Swift info and JSON info
            if let json: [String:Any] = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
                // the key "products" has a value of an array of dictionaries
                let products = json["products"] as? [[String:Any]]
            {
                if products.count > 0 {
                    // the first dictionary in products contains all the info about the product
                    let firstProduct = products[0]
                    
                    // accessing certain properties we want to know
                    if let barcode = firstProduct["barcode_number"] as? String,
                        let productName = firstProduct["product_name"] as? String,
                        let manufacturer = firstProduct["manufacturer"] as? String,
                        let brand = firstProduct["brand"] as? String,
                        let images = firstProduct["images"] as? [String]
                    {
                        // setting those values as attributes of productInfo
                        productInfo.barcode = barcode
                        productInfo.productName = productName
                        productInfo.manufacturer = manufacturer
                        productInfo.brand = brand
                        productInfo.imageURL = images[0]
                    }
                }
            }
            
            
        } catch {
            print(error)
        }
        
        return productInfo
    }
}

