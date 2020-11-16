//
//  CoreDataManager.swift
//  BSCodeTest
//
//  Created by Hanisa Mohamed on 16/11/20.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BSCodeTest")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of Store Failed: \(err)")
            }
        }
        return container
    }()
    
    
    func fetchPurchaseOrders() -> [PurchaseOrder] {
        //Core Data fetch
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<PurchaseOrder>(entityName: "PurchaseOrder")
        
        do {
            let purchaseOrders = try context.fetch(fetchRequest)
            return purchaseOrders
            
        } catch let fetchErr {
            print("Failed to fetch purchase orders: ", fetchErr)
            return []
        }
    }
    
}
