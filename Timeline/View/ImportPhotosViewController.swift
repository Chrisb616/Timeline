//
//  ImportPhotosViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/8/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class ImportPhotosViewController: NSViewController {
    
    static var instanceFromNib: ImportPhotosViewController {
        return ImportPhotosViewController(nibName: NSNib.Name("ImportPhotosViewController"), bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
