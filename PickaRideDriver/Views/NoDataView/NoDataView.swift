//
//  NoDataView.swift
//  PickaRideDriver
//
//  Created by Gaurang on 05/09/22.
//

import UIKit

class NoDataView: UIView {
    
    static func getInstance(_ message: String) -> NoDataView {
        let view: NoDataView = NoDataView.loadFromXib()
        view.messageLabel.text = message
        return view
    }

    @IBOutlet weak var messageLabel: UILabel!
    var message: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageLabel.text = message
    }
    
}
