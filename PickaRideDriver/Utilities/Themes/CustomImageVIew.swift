//
//  CustomImageVIew.swift
//  PickARide User
//
//  Created by Apple on 18/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import Foundation
import UIKit

class ProfileView : UIImageView {
    @IBInspectable var isViewRadius : Bool = false
    override func awakeFromNib() {
        if isViewRadius{
            self.layer.cornerRadius = self.layer.bounds.height / 2
        }
    }
}

class menuImageView : UIImageView {
    override func awakeFromNib() {
       
    }
    
   
}
