//
//  UICollectionViewCell+Extension.swift
//  HC Pro Patient
//
//  Created by Shraddha Parmar on 21/09/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

extension UIResponder {

     private static weak var _currentFirstResponder: UIResponder?

     static var currentFirstResponder: UIResponder? {
         _currentFirstResponder = nil
         UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)

         return _currentFirstResponder
     }

     @objc func findFirstResponder(_ sender: Any) {
         UIResponder._currentFirstResponder = self
     }

}
