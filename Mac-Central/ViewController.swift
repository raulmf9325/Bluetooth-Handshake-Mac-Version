//
//  ViewController.swift
//  Mac-Central
//
//  Created by Raul Mena on 3/11/19.
//  Copyright © 2019 Raul Mena. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var manager: BluetoothManager?
    
    var registeredDevices = [UUID]()

    @IBOutlet weak var numberOfPeripherals: NSTextField!
   
    @IBOutlet weak var textView: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        manager = BluetoothManager()
        manager?.delegate = self
        numberOfPeripherals.isEditable = false
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
}

extension ViewController: PeripheralUpdateDelegate{
    
    func handleCharacteristicUpdate(identifier: UUID) {
        
        if !registeredDevices.contains(identifier){
            
            registeredDevices.append(identifier)
            
            let integer = numberOfPeripherals.stringValue
            guard var number = Int(integer) else {return}
            number += 1
            let text = String(number)
            
            numberOfPeripherals.stringValue = text
            
            var uuids = textView.stringValue
            uuids.append("\n")
            uuids.append(identifier.uuidString)
            textView.stringValue = uuids
        }
        
    }
}

