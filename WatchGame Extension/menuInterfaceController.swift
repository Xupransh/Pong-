//
//  menuInterfaceController.swift
//  WatchSprite
//
//  Created by supransh on 4/3/17.
//  Copyright © 2017 jayanti supransh murty. All rights reserved.
//

import WatchKit
import Foundation


class menuInterfaceController: WKInterfaceController {
    
    
    @IBOutlet var start_button: WKInterfaceButton!
    
    var hidden = false
    var timer : Timer!




    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        
        
    
        
    }
        
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
         timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(toggleButton), userInfo: nil, repeats: true)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        self.timer.invalidate()

    }
    
    func toggleButton(){
    
    
    self.start_button .setHidden(!(self.hidden))
        self.hidden = !self.hidden
    
    }
    

    
    

}
