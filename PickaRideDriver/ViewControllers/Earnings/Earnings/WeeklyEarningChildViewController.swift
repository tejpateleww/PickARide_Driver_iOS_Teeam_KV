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
    @IBOutlet weak var lblCurrency: themeLabel!
    
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
    @IBOutlet weak var barChart: BarChartView!
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        self.view.addSubview(view)
        view.setAllSideContraints(.zero)
        return view
    }()
    
    private var info: EarningInfo?
    private var messageView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setValue()
        fetchEarningInfo()
    }

    private func setupView() {
        self.view.backgroundColor = themeColorOffWhite
        viewRideDetails.backgroundColor = themeColorOffGrey
        lblDate.text = "--"
        viewRideDetails.backgroundColor = themeColorOffGrey
        /*lblRideFares.text = ConstantString.LABEL_TITLE_EARNING_RIDE_FARE
        lblTaxiFee.text = ConstantString.LABEL_TITLE_EARNING_TAXI_FEE
        lblTax.text = ConstantString.LABEL_TITLE_EARNING_TAX
        lblToll.text = ConstantString.LABEL_TITLE_EARNING_TOLLS
        lblDiscount.text = ConstantString.LABEL_TITLE_EARNING_DISCOUNT
        lblSurge.text = ConstantString.LABEL_TITLE_EARNING_SURGE
        lblTotalEarnings.text = ConstantString.LABEL_TITLE_EARNING_TOTAL_EARNINGS*/
    }
    
    private func setValue() {
        contentView.isHidden = self.info != nil
        guard let info = self.info else {
            return
        }
        messageView?.removeFromSuperview()
        messageView = nil
        lblNumberOfRides.text = info.totalRide
        lblOnlineHours.text = info.totalHours
        lblCardRides.text = info.cardTotal
        lblAmount.text = info.totalEarning
        lblDate.text = "From \(info.startDate ?? "--") To \(info.endDate ?? "--")"
        setChartData(info.graphData)
    }
    
    private func setChartData(_ days: [EarningGraphData]) {
        barChart.setDataEntries(values: days.compactMap({$0.earning}), titles: days.map({$0.day.shortName}))
        barChart.reloadData()
    }
    
    private func showNoData(_ message: String) {
        messageView = NoDataView.getInstance(message)
        guard let messageView = messageView else {
            return
        }
        view.addSubview(messageView)
        messageView.setAllSideContraints(.zero)
    }
    
    
    
    private func fetchEarningInfo() {
        Utilities.showHUD()
        WebServiceSubClass.getEarning(isDaily: false) { (status, _, model, _) in
            Utilities.hideHUD()
            self.info = model?.data
            self.setValue()
            if status == false {
                self.showNoData(model?.message ?? "Data not available")
            }
        }
    }
}
