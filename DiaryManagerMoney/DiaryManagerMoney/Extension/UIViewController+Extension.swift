//
//  UIViewController+Extension.swift
//  DiaryManagerMoney
//
//  Created by cuongdd on 27/02/2024.
//  Copyright © 2024 Cuong. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func viewController<T: UIViewController>(from storyboard: String, storyboardID: String? = nil) -> T {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        if let identifier = storyboardID {
            return storyboard.instantiateViewController(withIdentifier: identifier) as! T
        }
        return storyboard.instantiateViewController(withIdentifier: classDomain(T.self)) as! T
    }
    
    func embedInNavigationController() -> UINavigationController {
        let navi = UINavigationController(rootViewController: self)
        navi.isMotionEnabled = true
        navi.navigationBar.isHidden = true
        return navi
    }
    
    static var identifierView: String {
        get {
            return String(describing: self)
        }
    }
    
    /// XIB
    static func xib() -> UINib? {
        return UINib(nibName: self.identifierView, bundle: nil)
    }
}

func classDomain<T>(_ object: T.Type) -> String {
    return String(describing: object)
}
