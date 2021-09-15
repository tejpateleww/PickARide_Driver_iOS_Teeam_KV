//
//  CancelRideView.swift
//  PickaRideDriver
//
//  Created by Mehul Panchal on 26/05/21.
//

import UIKit

protocol CancelRideViewDelgate {
    func onRideCanelDecision(decision : Int)
    func onSubmitCancelReason()
}

class CancelRideView: UIView {
    
    var delegate : CancelRideViewDelgate?
    var isselected = true
    var selectIndex = 0
    var arrReason = ["Rider isn't here","Wrong address shown","Don't charge rider"]
    let footerView = UIView()
    var currentBookingModel : CurrentBookingDatum?
    
    //MARK: -IBOutlets

    @IBOutlet weak var cancelReasonView: UIView!
    @IBOutlet weak var lblNavigationTitle: CommonLabel!
    @IBOutlet weak var btnCross: CommonButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSubmit: SubmitButton!
    
    @IBOutlet weak var cancelRideActionView: UIView!
    @IBOutlet weak var btnYes: CancelButton!
    @IBOutlet weak var btnNo: CancelButton!
    @IBOutlet weak var lblCancelActionTitle: CommonLabel!
    
    var noCancelClosure : (()->())?
    var YesCancelClosure : (()->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
         setupView()
    }

    func setRideDetails(/*Pass model class here*/) {
        let custName = (self.currentBookingModel?.customerInfo?.firstName)! + " " + (self.currentBookingModel?.customerInfo?.lastName)!
        lblCancelActionTitle.text = "Cancel \(custName)'s Ride?"
    }
    
    @IBAction func btnYesCancelClickAction(_ sender: Any)
    {
        if let obj = YesCancelClosure{
            obj()
        }
        delegate?.onRideCanelDecision(decision: 1)
    }
    
    @IBAction func btnCrossTap(_ sender: Any) {
        if let obj = noCancelClosure{
            obj()
        }
    }
    @IBAction func btnNoClickAction(_ sender: Any)
    {
        if let obj = noCancelClosure{
            obj()
        }
        delegate?.onRideCanelDecision(decision: 2)
    }
    
    @IBAction func btnSubmitClickAction(_ sender: Any)
    {
        delegate?.onSubmitCancelReason()
    }
}

extension CancelRideView {
    
    func setupView()
    {
        cancelReasonView.isHidden = true
        lblNavigationTitle.text = ConstantString.NAVIGATION_TITLE_CANCEL_RIDE
        lblCancelActionTitle.font = UIFont.bold(ofSize: FontsSize.Regular)
//        tableView.delegate = self
//        tableView.dataSource = self
        
        btnSubmit.setTitle(ConstantString.BUTTON_TITLE_DONE, for: .normal)
        btnYes.setTitle(ConstantString.BUTTON_TITLE_YES_CANCEL, for: .normal)
        btnNo.setTitle(ConstantString.BUTTON_TITLE_NO, for: .normal)
    }
}

//extension CancelRideView : UITableViewDelegate,UITableViewDataSource
//{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        return arrReason.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//        let cell:CancelRideCell = tableView.dequeueReusableCell(withIdentifier: CancelRideCell.className, for: indexPath) as! CancelRideCell
//
//        cell.lblReason.text = arrReason[indexPath.row]
//
//        if indexPath.row == selectIndex
//        {
//            cell.imgreasoncancel.image = #imageLiteral(resourceName: "imgCanceltrue")
//            cell.lblReason.textColor = UIColor(hexString: "#282F39")
//        } else
//        {
//            cell.imgreasoncancel.image = #imageLiteral(resourceName: "imgQuestionFalse")
//            cell.lblReason.textColor = UIColor(hexString: "#7F7F7F")
//        }
//
//        cell.selectionStyle = .none
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//    {
//        selectIndex = indexPath.row
//        tableView.reloadData()
//    }
//}

