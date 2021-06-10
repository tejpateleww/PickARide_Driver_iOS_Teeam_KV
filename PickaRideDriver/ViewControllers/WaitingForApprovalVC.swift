//
//  WaitingForApprovalVC.swift
//  PickaRideDriver
//
//  Created by Bhumi on 03/06/21.
//

import UIKit

class WaitingForApprovalVC: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var vwLoader: UIView!
    @IBOutlet weak var lblWaitingForApproval: themeLabel!
    @IBOutlet weak var btnOK: themeButton!
    
    //MARK:- Variables
    var NavigatetoHomeClosure : (()->())?

    override func viewDidLoad() {
        super.viewDidLoad()
        btnOK.setTitle("OK", for: .normal)
        
    }
   
    //MARK:- Custom Methods
    
    //MARK:- IBOutlets
    @IBAction func btnOkTap(_ sender: Any) {
        self.dismiss(animated: false, completion: {
            
            self.NavigatetoHomeClosure!()
        })
        
    }
    
}
