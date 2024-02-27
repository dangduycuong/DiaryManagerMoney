//
//  Identifier.swift
//  DiaryManagerMoney
//
//  Created by cuongdd on 27/02/2024.
//  Copyright © 2024 Cuong. All rights reserved.
//

import UIKit

//
// MARK: - Identifier
// Easily to get ViewID and XIB file
protocol Identifier {
    
    /// ID view
    static var identifierView: String {get}
    
    /// XIB - init XIB from identifierView
    static func xib() -> UINib?
}
