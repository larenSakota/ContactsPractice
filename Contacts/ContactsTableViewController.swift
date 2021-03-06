//
//  ContactsTableViewController.swift
//  Contacts
//
//  Created by Laren Sakota on 3/10/17.
//  Copyright © 2017 3..2..1..GO. All rights reserved.
//

import UIKit
import os.log


class ContactsTableViewController: UITableViewController {
    
    var contacts = [Contact]()


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved contacts, otherwise load sample data.
        if let savedContacts = loadContacts() {
            contacts += savedContacts
        }
//        else {
//            // Load the sample data.
//            loadSampleContacts()
//        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
//    func addBtnPressed(sender: UIBarButtonItem) {
//        self.performSegue(withIdentifier: "newContact", sender: self)
//    }
    
//    func addContact() {
//        let newContact = Contact(name: "New Contact")
//        self.contacts.append(newContact)
//        let newIndexPath = IndexPath(row: self.contacts.count - 1, section: 0)
//        self.tableView.insertRows(at: [newIndexPath], with: .automatic)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView.isEditing {
            return .none
        } else {
            return .delete
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ContactTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ContactTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ContactTableViewCell.")
        }
        
        // Fetches the appropriate contact for the data source layout.
        let contact = contacts[indexPath.row]
        
        cell.nameLabel.text = contact.name
        cell.phoneNumber.text = contact.number
        

        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)!
//        let contact = self.contacts[indexPath.row]
//        let destination = segue.destination as! DetailViewController
//        destination.contact = contact
//    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing of the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            contacts.remove(at: indexPath.row)
            saveContacts()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }


    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let contactMoving = contacts.remove(at: fromIndexPath.row)
        contacts.insert(contactMoving, at: destinationIndexPath.row)
        tableView.reloadData()

    }


    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new contact.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let contactDetailViewController = segue.destination as? DetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedContactCell = sender as? ContactTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedContactCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedContact = contacts[indexPath.row]
            contactDetailViewController.contact = selectedContact
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    //MARK: Actions
    
    @IBAction func unwindToContactList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? DetailViewController, let contact = sourceViewController.contact {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing contact.
                contacts[selectedIndexPath.row] = contact
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new contact.
                let newIndexPath = IndexPath(row: contacts.count, section: 0)
                
                contacts.append(contact)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the contacts.
            saveContacts()
        }
    }
    
//    private func loadSampleContacts() {
//        
//        guard let contact1 = Contact(name: "Sheilla Sakota", number: "123-456-7890") else {
//            fatalError("Unable to instantiate contact1")
//        }
//        
//            contacts += [contact1]
//    }
    
    private func saveContacts() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(contacts, toFile: Contact.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Contacts successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save contacts...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadContacts() -> [Contact]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Contact.ArchiveURL.path) as? [Contact]
    }

}
