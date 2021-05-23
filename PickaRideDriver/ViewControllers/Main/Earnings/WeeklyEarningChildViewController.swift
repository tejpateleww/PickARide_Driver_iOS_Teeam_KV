//
//  WeeklyEarningChildViewController.swift
//  PickaRideDriver
//
//  Created by Mehul Panchal on 12/05/21.
//

import UIKit

class WeeklyEarningChildViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblDate: EarningDetailLabel!
    @IBOutlet weak var lblAmount: EarningDetailLabel!
    
    @IBOutlet weak var viewRideCount: UIView!
    @IBOutlet weak var lblNumberOfRides: EarningDetailLabel!
    
    @IBOutlet weak var viewRideDetails: UIView!
    
    @IBOutlet weak var viewOnlineHours: UIView!
    @IBOutlet weak var lblOnlineHours: EarningDetailLabel!
    @IBOutlet weak var lblCardRides: EarningDetailLabel!
    
    @IBOutlet weak var lblRideFares: EarningDetailLabel!
    @IBOutlet weak var lblRideFareAmount: EarningDetailLabel!
    
    @IBOutlet weak var lblTaxiFee: EarningDetailLabel!
    @IBOutlet weak var lblTaxiFeeAmount: EarningDetailLabel!
    
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
    @IBOutlet weak var barChart: MSBBarChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.barChart.setOptions([.isHiddenLabelAboveBar(true), .yAxisNumberOfInterval(0)])
        self.barChart.assignmentOfColor =  [0.0..<0.14: #colorLiteral(red: 0, green: 0.6666666667, blue: 0.4941176471, alpha: 1), 0.14..<0.28: #colorLiteral(red: 0, green: 0.6666666667, blue: 0.4941176471, alpha: 1), 0.28..<0.42: #colorLiteral(red: 0, green: 0.6666666667, blue: 0.4941176471, alpha: 1), 0.42..<0.56: #colorLiteral(red: 0, green: 0.6666666667, blue: 0.4941176471, alpha: 1), 0.56..<0.70: #colorLiteral(red: 0, green: 0.6666666667, blue: 0.4941176471, alpha: 1), 0.70..<1.0: #colorLiteral(red: 0, green: 0.6666666667, blue: 0.4941176471, alpha: 1)]
        self.barChart.setDataEntries(values: [12,24,36,48,60,72,84])
        self.barChart.setXAxisUnitTitles(["M","T","W","TH","F","S","S"])
        self.barChart.start()
        var contentSize = self.scrollView.contentSize
        contentSize.height += 50
        self.scrollView.contentSize = contentSize
    }
    
    override func viewDidLayoutSubviews() {
        viewRideDetails.addTopBorderWithColor(color: themeColorOffGrey, width:1)
        viewRideCount.addRightBorderWithColor(color: themeColorOffGrey, width: 1)
        viewOnlineHours.addRightBorderWithColor(color: themeColorOffGrey, width: 1)
    }
    
    private func setupView() {
        
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
