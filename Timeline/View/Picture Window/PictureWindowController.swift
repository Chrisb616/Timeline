//
//  PictureWindowController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/11/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class PictureWindowController: NSWindowController {
    
    static func loadfor(picture: Picture) -> PictureWindowController {
        let windowController = PictureWindowController(windowNibName: NSNib.Name("PictureWindowController"))
        windowController.picture = picture
        windowController.window?.title = picture.title
        return windowController
    }
    
    weak var picture: Picture!
    
    var pictureDetailViewController: PictureDetailViewController!

    @IBAction func openWithPhotoshop(_ sender: Any) {
        NSWorkspace.shared.openFile(DirectoryManager.instance.imageFileURL(forPicture: picture).path, withApplication: "/Applications/Adobe Photoshop CC 2017/Adobe Photoshop CC 2017.app", andDeactivate: true)
    }
    
    @IBAction func deletePicture(_ sender: Any) {
        let alert = NSAlert.init()
        alert.icon = NSImage(named: NSImage.Name("Picture"))
        alert.messageText = "Are you sure you want to delete the picture \(self.picture.title)?"
        alert.addButton(withTitle: "Cancel")
        alert.addButton(withTitle: "Delete")
        alert.beginSheetModal(for: window!) { (response) in
            if response == NSApplication.ModalResponse.alertSecondButtonReturn {
                DataStore.instance.removePicture(self.picture)
                SaveDataManager.instance.deleteImage(forPicture: self.picture)
                MainWindowController.instance.pictureWindowController?.close()
                MainWindowController.instance.pictureWindowController?.pictureDetailViewController = nil
                MainWindowController.instance.pictureWindowController = nil
                NotificationManager.instance.postPictureUpdateNotification()
            }
        }
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        setUpDetailViewController()
    }
    
    func setUpDetailViewController() {
        self.pictureDetailViewController = PictureDetailViewController.instanceFromNib(forPicture: picture)
        self.contentViewController = pictureDetailViewController
    }
    
}

extension PictureWindowController: NSWindowDelegate {
    
    func windowDidResize(_ notification: Notification) {
        pictureDetailViewController?.resizeImage()
    }
    
}
