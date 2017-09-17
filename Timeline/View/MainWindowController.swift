//
//  MainWindowController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/7/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    //MARK: - Instance
    static var instance: MainWindowController = MainWindowController(windowNibName: NSNib.Name("MainWindowController"))
    
    //MARK; - View Controller
    var mainViewController: MainViewController?
    
    //MARK: - Window Controllers
    var eventWindowController: EventWindowController?
    var pictureWindowController: PictureWindowController?
    
    //MARK: - On Load
    override func windowDidLoad() {
        super.windowDidLoad()
        Debugger.log(string: "Main Window Loaded", logType: .process, logLevel: .verbose)
        
        window?.title = "Timeline"
        
        mainViewController = MainViewController.instanceFromNib
        contentViewController = mainViewController
        
        //configureTabViewController()
    }
    
    //MARK: - Toolbar
    @IBAction func switchTabToEvents(_ sender: Any) {
        //switchTab(to: .events)
    }
    
    @IBAction func switchTabToPictures(_ sender: Any) {
        //switchTab(to: .pictures)
    }
    
    @IBAction func createEvent(_ sender: Any) {
        //self.contentViewController?.presentViewControllerAsSheet(CreateEventViewController.instanceFromNib)
    }
    
    @IBAction func importPicturess(_ sender: Any) {
        /*
        let dialog = NSOpenPanel()
        
        dialog.title = "Select photos to import"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseDirectories = false
        dialog.canChooseFiles = true
        dialog.allowsMultipleSelection = true
        dialog.canCreateDirectories = false
        dialog.allowedFileTypes = SaveDataManager.instance.allowedImageFileTypes
        
        if dialog.runModal() == .OK {
            let urls = dialog.urls
            if urls.isEmpty{
                Debugger.log(string: "Could not use urls from dialog selection", logType: .failure, logLevel: .minimal)
                return
            } else {
                SaveDataManager.instance.importNewPictureFromSequence(urls: urls, index: 0)
            }
            
        }
        */
    }
    @IBAction func refreshAll(_ sender: Any) {
        //eventsViewController.update()
        //picturesViewController.update()
    }
    
    /*
    //MARK: - Tab View Controller
    enum TabViewControllerItem {
        case events
        case pictures
        
        var index: Int {
            switch self {
            case .events: return 0
            case .pictures: return 1
            }
        }
    }
    
    func configureTabViewController() {
        tabViewController.view.wantsLayer = true
        tabViewController.tabStyle = .unspecified
        
        let eventsViewController = EventsViewController.instanceFromNib
        let picturesViewController = PicturesViewController.instanceFromNib
        
        self.eventsViewController = eventsViewController
        self.picturesViewController = picturesViewController
        
        tabViewController.addChildViewController(eventsViewController)
        tabViewController.addChildViewController(picturesViewController)
        
        self.window?.contentViewController = tabViewController
    }
    
    func switchTab(to item: TabViewControllerItem) {
        tabViewController.selectedTabViewItemIndex = item.index
    }
    */
}
