//
//  giftcert.swift
//  Minerva
//
//  Created by James Ham on 30/12/16.
//  Copyright © 2016 Dominus Caeli. All rights reserved.
//

import Foundation
import CloudKit

struct giftcert {
    
    let record: CKRecord!
    let id: Int
    let giftto: String
    let giftfrom: String
    let package: CKReference
    let status: Int
    let expire: Date
    /*let pack_name: String*/
    
    init(id: Int, giftto: String, giftfrom: String, package: CKReference, status: Int, expire: Date/*, pack_name: String*/) {
        self.id = id
        self.giftto = giftto
        self.giftfrom = giftfrom
        self.package = package
        self.status = status
        self.expire = expire
        /*self.pack_name = pack_name*/
        record = CKRecord(recordType: "giftcert")
        record["id"] = id as CKRecordValue?
        record["giftto"] = giftto as CKRecordValue?
        record["giftfrom"] = giftfrom as CKRecordValue?
        record["package"] = package as CKRecordValue?
        record["status"] = status as CKRecordValue?
        record["expire"] = expire as CKRecordValue?
        /*record["pack_name"] = pack_name as CKRecordValue?*/
    }
    
    init(record : CKRecord) {
        self.record = record
        self.id = record["id"] as! Int
        self.giftto = record["giftto"] as! String
        self.giftfrom = record["giftfrom"] as! String
        self.package = record["package"] as! CKReference
        self.status = record["status"] as! Int
        self.expire = record["expire"] as! Date
        /*self.pack_name = record["pack_name"] as! String*/
        
    }
}

struct packages {

    let record: CKRecord!
    let pack_name: String
    let pack_ident: String
    let pack_status: Int
    
    init(pack_name: String, pack_ident: String, pack_status: Int) {
        self.pack_name = pack_name
        self.pack_ident = pack_ident
        self.pack_status = pack_status
        record = CKRecord(recordType: "package")
        record["pack_name"] = pack_name as CKRecordValue?
        record["pack_ident"] = pack_ident as CKRecordValue?
        record["pack_status"] = pack_status as CKRecordValue?
    }
    
    init(record : CKRecord) {
        self.record = record
        self.pack_name = record["pack_name"] as! String
        self.pack_ident = record["pack_ident"] as! String
        self.pack_status = record["pack_status"] as! Int
    }
}
