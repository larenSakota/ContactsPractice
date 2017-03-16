//
//  Contact.swift
//  Contacts
//
//  Created by Laren Sakota on 3/12/17.
//  Copyright © 2017 3..2..1..GO. All rights reserved.
//

import UIKit
import os.log


class Contact: NSObject, NSCoding {
    
    //MARK: Properties
    
    var name: String
    var number: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("contacts")
    
    //MARK: Types
    
    struct Person {
        static let name = "name"
        static let number = "number"
    }
    
    //MARK: Initialization
    
    init?(name: String, number: String) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
//        // The number must not be empty
//        guard !number.isEmpty else {
//            return nil
//        }
        
        
        // Initialization should fail if there is no name.
        if name.isEmpty {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.number = number
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Person.name)
        aCoder.encode(number, forKey: Person.number)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: Person.name) as? String else {
            os_log("Unable to decode the name for a Contact object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let number = aDecoder.decodeObject(forKey: Person.number) as? String else {
            os_log("Unable to decode the number for a Contact object.", log: OSLog.default, type: .debug)
            return nil
        }

        
        
        // Must call designated initializer.
        self.init(name: name, number: number)
        
    }
}

