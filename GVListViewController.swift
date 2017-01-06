//
//  ViewController.swift
//  Minerva
//
//  Created by James Ham on 30/12/16.
//  Copyright © 2016 Dominus Caeli. All rights reserved.
//

import UIKit
import CloudKit

class GVListViewController: UITableViewController {
    
    let model = Model.sharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        let addButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(addNewObject))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshList))
        navigationItem.rightBarButtonItems = [addButton, refreshButton]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        model.delegate = self
        model.refreshPublicDB()
    }
    
    func refreshList() {
        model.refreshPublicDB()
    }
    
    func addNewObject() {
        let alert = UIAlertController(title: "NEW", message: "Today I Learned", preferredStyle: .alert)
        
        alert.addTextField { giftto in
            giftto.placeholder = "Gift To"
            giftto.autocapitalizationType = .allCharacters
            giftto.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
    }
        
        alert.addTextField { giftfrom in
            giftfrom.placeholder = "Gift To"
            giftfrom.autocapitalizationType = .words
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        let addAction = UIAlertAction(title: "Add", style: .default) { action in
            guard let text = alert.textFields?[1].text , !text.isEmpty else {
                print("It Broken")
                return
            }
            
            guard let shortText = alert.textFields?.first?.text,
                let longText = alert.textFields?[1].text else {
                    return
            }
            
            /*let newObject = giftcert(id: 0, giftto: shortText, giftfrom: longText, package: shortText as CKReference, status: 0, expire: Date())
            self.model.items.append(newObject)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            self.model.publicDB.save(newObject.record!, completionHandler: { _, error in
                if let error = error {
                    print(error)
                }
            })*/
        }
        
        addAction.isEnabled = false
        alert.addAction(addAction)
        present(alert, animated: true, completion: nil)
    }
    
    func alertTextFieldDidChange(_ sender: UITextField) {
        let controller = presentedViewController as! UIAlertController
        if let input = sender.text {
            if input.characters.count < 1 {
                (controller.actions.last! as UIAlertAction).isEnabled = false
                return
            }
        }
        (controller.actions.last! as UIAlertAction).isEnabled = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return model.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GVListCell", for: indexPath) as! GVTableViewCell
        let object = model.items[(indexPath as NSIndexPath).row]
        let id = String(format: "%04d", object.id)
        cell.giftIDLabel.text = id
        cell.giftToLabel.text = object.giftto
        cell.giftFromLabel.text = object.giftfrom
        
        if(object.status == 0) {
            if(object.expire > Date()) {
                    cell.statusLabel.text = "Valid"
                    cell.statusLabel.textColor = UIColor(red:0.00, green:0.45, blue:0.00, alpha:1.0)
                    /*cell.statusLabel.textShadow =*/
            } else {
                cell.statusLabel.text = "Expired"
                cell.statusLabel.textColor = UIColor(red: 0.74, green: 0.00, blue: 0.00, alpha: 1.0)
            }
        } else {
                cell.statusLabel.text = "Used"
            cell.statusLabel.textColor = UIColor(red:0.89, green: 0.67, blue: 0.00, alpha: 1.0)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0;
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removedItem = model.items.remove(at: (indexPath as NSIndexPath).row)
            model.publicDB.delete(withRecordID: (removedItem.record?.recordID)!) { record, error in
                if let error = error {
                    print(error)
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension GVListViewController: ModelDelegate {
    func publicDBUpdated() {
        tableView.reloadData()
    }
        
    func errorUpdating(_ error: NSError) {
        print(error)
    }
}
