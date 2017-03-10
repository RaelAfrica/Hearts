//
//  ViewController.swift
//  Hearts
//
//  Created by Rael Kenny on 2/14/17.
//  Copyright © 2017 Rael Kenny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //output
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var heart: UIImageView!
    
    //properties
    let hearts = ["pink", "blue", "orange", "yellow", "purple", "green"]
    
    //register to be first responder
    override var canBecomeFirstResponder: Bool
    { return true }

    //override motion ended method
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
    //check if motion was a shake?
        if motion == .motionShake {
            getNewMessage()
        }
    }
    
    
    func getNewMessage() {
        let url = URL(string: "https://v.aswifter.guide/heart/")!
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            //check if data exists
            guard let myData = data
                else { return }
            
            //de-serialize data to JSON (Dictionary)
            guard let json = try? JSONSerialization.jsonObject(with: myData,
                                                            options: []) as! [String: String]
                else { return }
            
            print(json)
            
            //get and check the text exists
            guard let text = json["text"]
                else { return }
            
            //end goal: put this into our text label
            //we are in the background and need to get to the foreground: MainQueue
            
            DispatchQueue.main.async {
                
                UIView.transition(with: self.text, duration: 1, options: .transitionFlipFromTop, animations: {
                  self.text.text = text
                }, completion: nil)
                
    
                //1. get a random using arc4random_uniform
                //2. get a random heart from the hearts array
                let randomNumber = Int(arc4random_uniform(UInt32(self.hearts.count))) //1
                let heartName = self.hearts[randomNumber]//2
                
                //3. set it to the heart image view
//                self.heart.image = UIImage(named: heartName)
                
                
                UIView.transition(with: self.heart, duration: 1, options: .transitionCrossDissolve, animations: {
                    self.heart.image = UIImage(named: heartName) //3
                }, completion: nil)
                
            }
            
            
        }.resume()
        
    }
    
    

}

