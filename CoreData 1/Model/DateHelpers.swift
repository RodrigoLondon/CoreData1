//
//  DateHelpers.swift
//  CoreData 1
//
//  Created by Lewis Jones on 07/09/2018.
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import Foundation


extension Date {
    
    
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: self)
        
    }
}


