//
//  CancelRideVC.swift
//  PickaRideDriver
//
//  Created by Admin on 08/05/21.
//

import UIKit

class CancelRideVC: BaseVC {
    var isselected = true    //MARK: -IBOutlets
    var selectIndex = 0
    var arrReason = ["Rider isn't here","Wrong address shown","Don't charge rider"]
    let footerView = UIView()
    var cancelReqClosure : (()->())?
    @IBOutlet weak var tblReasonForCancel: UITableView!
    @IBOutlet weak var btnDone: themeButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.CancelRide.value, leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        tblReasonForCancel.delegate = self
        tblReasonForCancel.dataSource = self
        tblReasonForCancel.reloadData()
        footerView.backgroundColor = .white
        self.tblReasonForCancel.tableFooterView = footerView
        // Do any additional setup after loading the view.
    }
    @IBAction func btnDoneTap(_ sender: Any) {
        if let CancelRequest = cancelReqClosure{
            CancelRequest()
        }
        self.navigationController?.popToRootViewController(animated: true)
     
    }
    
}
extension  CancelRideVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrReason.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CancelRideCell = tblReasonForCancel.dequeueReusableCell(withIdentifier: CancelRideCell.className, for: indexPath)as! CancelRideCell
        cell.lblReason.text = arrReason[indexPath.row]
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
        tblReasonForCancel.reloadData()
    }
}
