//
//  Model.swift
//  Minerva
//
//  Created by James Ham on 30/12/16.
//  Copyright © 2016 Dominus Caeli. All rights reserved.
//

import Foundation
import CloudKit

protocol ModelDelegate {
    func errorUpdating(_ error: NSError)
    func publicDBUpdated()
}

final class Model {
    
    let container: CKContainer
    let publicDB: CKDatabase
    
    init() {
        container = CKContainer.default()
        publicDB = container.publicCloudDatabase
    }
    
    var items: [giftcert] = []
    var packs: [packages] = []
    /*var transact: [transact] = []*/
    
    // MARK: - Model singleton
    
    static let _sharedInstance = Model()
    class func sharedInstance() -> Model {
        return _sharedInstance
    }
    
    var delegate: ModelDelegate?
    
    func refreshPublicDB() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "giftcert", predicate: predicate)
        let sort = NSSortDescriptor(key: "id", ascending: true)
        query.sortDescriptors = [sort]
        
        publicDB.perform(query, inZoneWith: nil) { results, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.delegate?.errorUpdating(error as NSError)
                }
            } else {
                self.items.removeAll(keepingCapacity: true)
                for record in results! {
                    let item = giftcert(record: record)
                    self.items.append(item)
                    let packy = NSPredicate(format:"package == %@", record)
                    let qpack = CKQuery(recordType: "package", predicate: predicate)
                    self.publicDB.perform(qpack, inZoneWith: nil) { results, error in
                        if let error = error {
                            DispatchQueue.main.async {
                                self.delegate?.errorUpdating(error as NSError)
                            }
                        } else {
                                for record in results! {
                                    let pack = packages(record: record)
                                    self.packs.append(pack)
                                    print("%@", record.object(forKey:"pack_name"))
                            }
                        }
                        DispatchQueue.main.async {
                            self.delegate?.publicDBUpdated()
                    }
                }
            }
        }
}
}
}
