//
//  JSONService.swift
//  BSCodeTest
//
//  Created by Hanisa Mohamed on 18/11/20.
//

import Foundation
import CoreData

struct JSONService {
    
    static let shared = JSONService()
    
    let urlString = "https://my-json-server.typicode.com/butterfly-systems/sample-data/purchase_orders"
    
    func downloadPurchaseOrdersFromServer() {
        print("Attempting to download po")
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print("Finished Downloading")
            
            if let error = error {
                print("Failed to download PO.", error)
                return
            }
            guard let data = data else { return }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let jsonPurchaseOrders = try jsonDecoder.decode([JSONPurchaseOrder].self, from: data)
                
                let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                
                privateContext.parent = CoreDataManager.shared.persistentContainer.viewContext
                
                jsonPurchaseOrders.forEach { (jsonPurchaseOrder) in
                    
                    // Getting app Objects from JSON to CoreData
                    let purchaseOrder = PurchaseOrder(context: privateContext)
                    purchaseOrder.poID = String(jsonPurchaseOrder.id)
                    purchaseOrder.noItems = String(jsonPurchaseOrder.items.count)
                    
                    //Formatting JSON date
                    
                    let dateFormatter = DateFormatter()
//                    let jsonDate = dateFormatter.date(from: jsonPurchaseOrder.last_updated)
                    dateFormatter.dateStyle = .medium
                    dateFormatter.timeStyle = .medium
                    dateFormatter.locale = Locale(identifier: "en_US")
                    let jsonDate = dateFormatter.date(from: jsonPurchaseOrder.last_updated)
                    purchaseOrder.lastUpdated = jsonDate
                    print("DATE", jsonDate)
                    
                    jsonPurchaseOrder.items.forEach { (jsonItem) in
                        
                        // Getting each item
                        let item = Item(context: privateContext)
                        item.itemID = String(jsonItem.id)
                        item.quantity = String(jsonItem.quantity)
                        item.purchaseOrder = purchaseOrder
                    }
                    
                    // Save Context
                    do {
                        try privateContext.save()
                        try privateContext.parent?.save()
                        
                    } catch let saveError {
                        print("Error Saving purchaseOrders", saveError)
                    }
                    
                    
                    
                }
                
            } catch let jsonError {
                print("Failed to decode json data: ", jsonError)
            }
            
            
        }.resume()
    }
    
}


struct JSONPurchaseOrder: Decodable {
    let id: Int
    let items: [JSONItem]
    let last_updated: String
}

struct JSONItem: Decodable {
    let id: Int
    let quantity: Int
}

