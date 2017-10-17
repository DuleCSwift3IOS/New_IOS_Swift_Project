//
//  OtherExtensionsAndFunctions.swift
//  FindNearestPetrolsV2
//
//  Created by Dushko Cizaloski on 9/26/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import Foundation
//Running something on the background thread looks like this:
//DispatchQueue.global(qos: .background).async {
//  print("This is run on the background queue")
//  
//  DispatchQueue.main.async {
//    print("This is run on the main queue, after the previous code in outer block")
//  }
//}
/*
 The best practice is to define a reusable function that can be accessed multiple times.
 
 REUSABLE FUNCTION:
 
 e.g. somewhere like AppDelegate.swift as a Global Function.
 
 func backgroundThread(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
 dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) {
 if(background != nil){ background!(); }
 
 let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
 dispatch_after(popTime, dispatch_get_main_queue()) {
 if(completion != nil){ completion!(); }
 }
 }
 }
 */
func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
  DispatchQueue.main.async {
    updates()
  }
}
