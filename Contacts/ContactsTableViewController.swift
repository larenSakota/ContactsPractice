//
//  ContactsTableViewController.swift
//  Contacts
//
//  Created by Laren Sakota on 3/10/17.
//  Copyright © 2017 3..2..1..GO. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    var contacts: [Contact] = []


    override func viewDidLoad() {
        super.viewDidLoad()

//        tableView.setEditing(true, animated: true)
        
//        let moveButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(ContactsTableViewController.toggleEdit))
//        navigationItem.leftBarButtonItem = moveButton
        navigationItem.leftBarButtonItem = editButtonItem
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ContactsTableViewController.addContact))
        navigationItem.rightBarButtonItem = addButton
    
        let sheilla = Contact(phoneNumber: "867-5309")
        let laren = Contact(name: "Laren", phoneNumber: "888-888-8888")
        let ging = Contact(name: "Ging")
        
        self.contacts.append(sheilla)
        self.contacts.append(laren)
        self.contacts.append(ging)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func addContact() {
        let newContact = Contact(name: "New Contact")
        self.contacts.append(newContact)
        let newIndexPath = IndexPath(row: self.contacts.count - 1, section: 0)
        self.tableView.insertRows(at: [newIndexPath], with: .automatic)
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
    
//    func toggleEdit() {
//        tableView.setEditing(!tableView.isEditing, animated: true)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contacts", for: indexPath)
        
        let contact = self.contacts[indexPath.row]
        
        if let name = contact.name {
            cell.textLabel?.text = name
        } else {
            cell.textLabel?.text = "No Name"
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)!
        let contact = self.contacts[indexPath.row]
        let destination = segue.destination as! DetailViewController
        destination.contact = contact
    }


//     Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.contacts.remove(at: indexPath.row)
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
//        swap(&contacts[fromIndexPath.row], &contacts[destinationIndexPath.row])
//        tableView.reloadData()
    }


    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
