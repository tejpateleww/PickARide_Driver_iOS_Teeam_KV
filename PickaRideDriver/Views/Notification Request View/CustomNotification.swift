//
//  CustomNotification.swift
//  PickaRideDriver
//
//  Created by Tej on 20/10/21.
//

import UIKit

class CustomNotification: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var lblTitle: themeLabel!
    @IBOutlet weak var lblSubTitle: themeLabel!
    @IBOutlet weak var lblTime: themeLabel!
    @IBOutlet weak var timeView: UIView!
    
    var counter = 15
    var timer : Timer?
    
    override init(frame : CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        self.contentView.cornerRadius = 10
    }
    
    static func instantiate(Title: String, SubTitle: String) -> CustomNotification {
        let view: CustomNotification = initFromNib()
        view.lblTitle.text = Title
        view.lblSubTitle.text = SubTitle
        
        view.timeView.layer.cornerRadius = view.timeView.frame.size.width/2
        view.timeView.clipsToBounds = true
        
        return view
    }
    
    @objc func timerAction() {
        if self.counter > 0{
            self.counter -= 1
            self.lblTime.text =  "\(self.counter)"
        } else {
            self.counter = 15
            self.timer?.invalidate()
        }
    }
    
}
