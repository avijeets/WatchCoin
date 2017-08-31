//
//  InterfaceController.swift
//  WatchCoin WatchKit Extension
//
//  Created by Avijeet Sachdev on 8/30/17.
//  Copyright © 2017 Avijeet Sachdev. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet var priceLabel: WKInterfaceLabel!
    
    @IBOutlet var updatingLabel: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        getPrice()
    }
    
    func getPrice() {
        let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")!
        URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                //success
                print("It worked")
                
                if data != nil {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                        guard let bpi = json["bpi"] as? [String:Any], let USD = bpi["USD"] as? [String:Any], let rateFloat = USD["rate_float"] as? Float else {
                            return
                        }
                        self.priceLabel.setText("\(rateFloat)")
                    }
                    catch {}
                }
            }
            else {
                print("Error caught")
            }
        }.resume()
    }

}
