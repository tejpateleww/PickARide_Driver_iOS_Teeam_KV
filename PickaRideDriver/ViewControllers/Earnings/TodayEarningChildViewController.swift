//
//  TodayEarningChildViewController.swift
//  PickaRideDriver
//
//  Created by Mehul Panchal on 12/05/21.
//

import UIKit

class TodayEarningChildViewController: UIViewController {

    @IBOutlet weak var lblDate: EarningDetailLabel!
    @IBOutlet weak var lblAmount: EarningDetailLabel!
    
    @IBOutlet weak var viewRideCount: UIView!
    @IBOutlet weak var lblNumberOfRides: EarningDetailLabel!
    
    @IBOutlet weak var viewOnlineHours: UIView!
    @IBOutlet weak var lblOnlineHours: EarningDetailLabel!
    
    @IBOutlet weak var lblCardRides: EarningDetailLabel!
    
    @IBOutlet weak var viewRideDetails: UIView!
    @IBOutlet weak var lblTaxiFee: EarningDetailLabel!
    @IBOutlet weak var lblTaxiFeeAmount: EarningDetailLabel!
    @IBOutlet weak var lblRideFares: EarningDetailLabel!
    @IBOutlet weak var lblRideFareAmount: EarningDetailLabel!
    @IBOutlet weak var lblTax: EarningDetailLabel!
    @IBOutlet weak var lblTaxAmount: EarningDetailLabel!
    @IBOutlet weak var lblToll: EarningDetailLabel!
    @IBOutlet weak var lblTollAmount: EarningDetailLabel!
    @IBOutlet weak var lblDiscount: EarningDetailLabel!
    @IBOutlet weak var lblDiscountAmount: EarningDetailLabel!
    @IBOutlet weak var lblSurge: EarningDetailLabel!
    @IBOutlet weak var lblSurgeAmount: EarningDetailLabel!
    @IBOutlet weak var lblTotalEarnings: EarningDetailLabel!
    @IBOutlet weak var lblTotalEarningAmount: EarningDetailLabel!
    @IBOutlet weak var lblCurrency: themeLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        viewRideDetails.addTopBorderWithColor(color: themeColorOffGrey, width:1)
        viewRideCount.addRightBorderWithColor(color: themeColorOffGrey, width: 1)
        viewOnlineHours.addRightBorderWithColor(color: themeColorOffGrey, width: 1)
    }
    
    private func setupView()
    {
        self.view.backgroundColor = themeColorOffWhite
        
        lblRideFares.text = ConstantString.LABEL_TITLE_EARNING_RIDE_FARE
        lblTaxiFee.text = ConstantString.LABEL_TITLE_EARNING_TAXI_FEE
        lblTax.text = ConstantString.LABEL_TITLE_EARNING_TAX
        lblToll.text = ConstantString.LABEL_TITLE_EARNING_TOLLS
        lblDiscount.text = ConstantString.LABEL_TITLE_EARNING_DISCOUNT
        lblSurge.text = ConstantString.LABEL_TITLE_EARNING_SURGE
        lblTotalEarnings.text = ConstantString.LABEL_TITLE_EARNING_TOTAL_EARNINGS
    }

}

