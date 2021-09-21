//
//  CancelRideVC.swift
//  PickaRideDriver
//
//  Created by Admin on 08/05/21.
//

import UIKit

protocol CancelTripReasonDelgate {
    func onCancelTripConfirm(strReason : String)
    func onCancelTripReject()
}

class CancelRideVC: BaseVC {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tblReasonForCancel: UITableView!
    @IBOutlet weak var btnDone: themeButton!
    @IBOutlet weak var tblReasonForCancelHeight: NSLayoutConstraint!

    //MARK: - Variables
    var isselected = true
    var isOtherselected = false
    var strReason = ""
    var selectIndex = 0
    var arrReason = [cancelReasonDatum]()
    var doneClosure : (()->())?
    let footerView = UIView()
    var cancelTripViewModel = CancelTripViewModel()
    var delegate : CancelTripReasonDelgate?
    
    //MARK: - Lfe Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.CancelRide.value, leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        self.tblReasonForCancel.delegate = self
        self.tblReasonForCancel.dataSource = self
        self.tblReasonForCancel.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)

        footerView.backgroundColor = .white
        self.tblReasonForCancel.tableFooterView = footerView
        
        self.callcancelTripReasonsAPI()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){
            if let info = object, let collObj = info as? UITableView{
                if collObj == self.tblReasonForCancel{
                    self.tblReasonForCancelHeight.constant = self.tblReasonForCancel.contentSize.height
                }
            }
        }
    }
    
    func Validate() -> Bool{
        if(self.isOtherselected){
            Toast.show(title: UrlConstant.Failed, message: "Please proview Reason...", state: .failure)
            return false
        }else{
            self.strReason = (self.strReason == "") ? self.arrReason[0].reason ?? "" : self.strReason
            if(self.strReason == ""){
                Toast.show(title: UrlConstant.Failed, message: "Please proview Reason...", state: .failure)
                return false
            }else{
                return true
            }
        }
    }
    
    func openPopup(){
        let vc : CancelReasonPopUpVC = CancelReasonPopUpVC.instantiate(fromAppStoryboard: .Main)
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - Button action methods
    @IBAction func btnDoneTap(_ sender: Any) {
        if(Validate()){
            delegate?.onCancelTripConfirm(strReason: self.strReason)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func btnBackAction() {
        delegate?.onCancelTripReject()
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension  CancelRideVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrReason.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CancelRideCell = tblReasonForCancel.dequeueReusableCell(withIdentifier: CancelRideCell.className, for: indexPath)as! CancelRideCell
        cell.lblReason.text = arrReason[indexPath.row].reason ?? ""
        
        if indexPath.row == selectIndex {
           cell.imgreasoncancel.image = #imageLiteral(resourceName: "ImgRightArrow")
            cell.lblReason.textColor = UIColor(hexString: "#282F39")
        } else {
            cell.imgreasoncancel.image = #imageLiteral(resourceName: "unchacked")
            cell.lblReason.textColor = UIColor(hexString: "#7F7F7F")
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectIndex = indexPath.row
        self.tblReasonForCancel.reloadData()
        
        if(arrReason[indexPath.row].reason == "Others"){
            self.isOtherselected = true
            self.strReason = arrReason[indexPath.row].reason ?? ""
            self.openPopup()
        }else{
            self.isOtherselected = false
            self.strReason = arrReason[indexPath.row].reason ?? ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK:- Api Calls
extension CancelRideVC{
    
    func callcancelTripReasonsAPI(){
        self.cancelTripViewModel.cancelRideVC = self
        self.cancelTripViewModel.webserviceGetCancelTripReasonsAPI()
    }

}

extension CancelRideVC : UITextViewDelegate{
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
    }
}

//MARK:- CancelRideFromOtherViewDelgate
extension CancelRideVC : CancelRideFromOtherViewDelgate{
    func onCancelRideFromOtherCancel() {
        self.isOtherselected = false
        self.selectIndex = 0
        self.strReason = arrReason[self.selectIndex].reason ?? ""
        self.tblReasonForCancel.reloadData()
    }
    
    func onCancelRideFromOther(StrReason: String) {
        delegate?.onCancelTripConfirm(strReason: StrReason)
        self.navigationController?.popViewController(animated: true)
    }
}
