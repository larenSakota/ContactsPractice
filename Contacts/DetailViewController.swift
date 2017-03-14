//
//  DetailViewController.swift
//  Contacts
//
//  Created by Laren Sakota on 3/12/17.
//  Copyright © 2017 3..2..1..GO. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var nameField: UITextField!
    @IBOutlet var phoneNumberField: UITextField!
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameField.delegate = self
        self.phoneNumberField.delegate = self
        
        if let contact = self.contact {
            if let name = contact.name {
                self.nameField.text = name
            }
            if let phoneNumber = contact.phoneNumber {
                self.phoneNumberField.text = phoneNumber
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.nameField {
            self.contact?.name = textField.text
        } else if textField == self.phoneNumberField {
            self.contact?.phoneNumber = textField.text
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
