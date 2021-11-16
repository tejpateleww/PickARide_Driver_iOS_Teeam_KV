//
//  MyRidesVC.swift
//  PickARide User
//
//  Created by baps on 16/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import UIView_Shimmer

class MyRidesVC: BaseVC {
    
    //MARK: -IBOutlets
    @IBOutlet weak var btnUpcoming: MyRidesButton!
    @IBOutlet weak var viewTblRideType: UIView!
    @IBOutlet weak var tblMyRides: UITableView!
    @IBOutlet weak var tblMyRideType: UITableView!
    
    //MARK: -Properties
    var pastCurrentPage = 1
    var InProgressCurrentPage = 1
    var upcomingCurrentPage = 1
    var isApiProcessing = false
    var isStopPaging = false
    var arrRides = [PastBookingResDatum]()
    var myRideArr = ["PAST","INPROCESS","UPCOMING"]
    var selectedMyRideState = 1
    var ridesViewModel = RidesViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    //MARK: -View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareView()
        self.callInProcessBookingRideAPI()
    }
    
    //MARK: - Custom methods
    func prepareView(){
        self.setNavigationBarInViewController(controller: self, naviColor: colors.myride.value, naviTitle: "My Rides", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        
        self.tblMyRides.delegate = self
        self.tblMyRides.dataSource = self
        self.tblMyRides.isHidden = true
        
        self.tblMyRideType.delegate = self
        self.tblMyRideType.dataSource = self
        self.tblMyRideType.frame.origin.y = -8
        self.tblMyRideType.frame.size.height = 0
        self.tblMyRideType.reloadData()
        self.viewTblRideType.isHidden = true
        
        self.btnUpcoming.setTitle(self.myRideArr[self.selectedMyRideState], for: .normal)
        self.registerNIB()
    }
    
    func registerNIB(){
        tblMyRides.register(UINib(nibName:NoDataTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NoDataTableViewCell.reuseIdentifier)
    }
    
    func setRideTableView() {
        if self.viewTblRideType.isHidden {
            self.viewTblRideType.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.btnUpcoming.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
                self.tblMyRideType.frame.size.height = self.tblMyRideType.contentSize.height * 2
            }, completion: {finished in
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnUpcoming.imageView?.transform = CGAffineTransform(rotationAngle: 0)
                self.tblMyRideType.frame.size.height = 0
            }, completion: {finished in
                self.viewTblRideType.isHidden = true
            })
        }
    }
    
    //MARK: -IBActions
    @IBAction func btnMyRidesTap(_ sender: Any) {
        self.setRideTableView()
    }
    
}

//MARK: - UITableViewDelegate methods
extension MyRidesVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        switch tableView{
        case self.tblMyRides:
            if self.arrRides.count > 0 {
                return self.arrRides.count
            } else {
                return 1
            }
        case self.tblMyRideType:
            return self.myRideArr.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch tableView{
        
        case self.tblMyRides:
            
            if (self.arrRides.count != 0){
                let cell:MyRideCell = self.tblMyRides.dequeueReusableCell(withIdentifier: MyRideCell.reuseIdentifier, for: indexPath)as! MyRideCell
                let dict = self.arrRides[indexPath.row]
                let BookingStatus = dict.bookingInfo?.status ?? ""
                let BookingType = dict.bookingInfo?.bookingType ?? ""
                
                let timestamp: TimeInterval = (self.selectedMyRideState == 0) ? Double(dict.bookingInfo?.acceptTime ?? "") ?? 0.0 : (self.selectedMyRideState == 1) ? Double(dict.bookingInfo?.bookingTime ?? "") ?? 0.0 : Double(dict.bookingInfo?.pickupDateTime ?? "") ?? 0.0
                let date = Date(timeIntervalSince1970: timestamp)
                let formatedDate = date.timeAgoSinceDate(isForNotification: false)
                cell.lblDate.text = formatedDate
                
                if self.selectedMyRideState == 0 {
                    cell.stackButtons.isHidden = true
                    cell.stackButtonsHeight.constant = 0
                    if(BookingStatus == "canceled"){
                        cell.imgStatus.image = #imageLiteral(resourceName: "Cancel")
                    }else if(BookingStatus == "completed"){
                        cell.imgStatus.image = #imageLiteral(resourceName: "Completed")
                    }
                }else if self.selectedMyRideState == 1{
                    cell.stackButtons.isHidden = true
                    cell.stackButtonsHeight.constant = 0
                    if(BookingType == "book_now"){
                        cell.imgStatus.image = #imageLiteral(resourceName: "OnGoing")
                    }else if(BookingType == "book_later"){
                        cell.imgStatus.image = #imageLiteral(resourceName: "Pending")
                    }
                    
                }else{
                    cell.stackButtons.isHidden = false
                    cell.stackButtonsHeight.constant = 40
                    if(BookingStatus == "accepted"){
                        cell.btnReject.isHidden = false
                        cell.btnReject.setTitle("CANCEL", for: .normal)
                        cell.btnAccept.isHidden = true
                    }else{
                        cell.btnAccept.isHidden = false
                        cell.btnReject.isHidden = true
                    }
                    cell.imgStatus.image = #imageLiteral(resourceName: "Pending")
                }
                
                if self.selectedMyRideState == 0 {
                    cell.lblAmount.text = "$\(dict.bookingInfo?.driverAmount ?? "0")"
                }else if self.selectedMyRideState == 1{
                    cell.lblAmount.text = "$\(dict.bookingInfo?.estimatedFare ?? "0")"
                }else{
                    cell.lblAmount.text = "$\(dict.bookingInfo?.estimatedFare ?? "0")"
                }
                
                cell.lblAddress.text = dict.bookingInfo?.pickupLocation ?? ""
                let custName = (dict.bookingInfo?.customerFirstName)! + " " + (dict.bookingInfo?.customerLastName)!
                cell.lblRideName.text = custName
                
                
                cell.AcceptTapped = {
                    print("Accept called....")
                    self.callAcceptBookingRideAPI(Id: dict.bookingInfo?.id ?? "")
                }
                cell.RejectTapped = {
                    print("Reject called....")
                }
                
                return cell
                
            }else{
                let NoDatacell = self.tblMyRides.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
                return NoDatacell
            }
            
        case self.tblMyRideType:
            let cell:pastUpcomingCell = self.tblMyRideType.dequeueReusableCell(withIdentifier: pastUpcomingCell.reuseIdentifier, for: indexPath)as! pastUpcomingCell
            cell.MyRidesLabel.text = self.myRideArr[indexPath.row]
            if indexPath.row == self.selectedMyRideState {
                cell.imgDone.isHidden = false
            }else{
                cell.imgDone.isHidden = true
            }
            return cell
            
        default:
            print("Something is Wrong")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch tableView {
        
        case self.tblMyRides:
            if self.selectedMyRideState == 0 {
                let vc : RideDetailsVC = RideDetailsVC.instantiate(fromAppStoryboard: .Main)
                vc.isFromPast = true
                vc.PastBookingData = arrRides[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.selectedMyRideState == 1 {
                let vc : RideDetailsVC = RideDetailsVC.instantiate(fromAppStoryboard: .Main)
                vc.isFromInprogress = true
                vc.PastBookingData = arrRides[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc : RideDetailsVC = RideDetailsVC.instantiate(fromAppStoryboard: .Main)
                vc.isFromUpcomming = true
                vc.delegate = self
                vc.PastBookingData = arrRides[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
            
        case self.tblMyRideType:
            self.selectedMyRideState = indexPath.row
            self.btnUpcoming.setTitle(self.myRideArr[self.selectedMyRideState], for: .normal)
            self.tblMyRideType.reloadData()
            self.setRideTableView()
            self.isApiProcessing = false
            self.isStopPaging = false
            
            if(self.selectedMyRideState == 0){
                self.pastCurrentPage = 1
                self.callRideHistoryAPI()
            }else if (self.selectedMyRideState == 1){
                self.InProgressCurrentPage = 1
                self.callInProcessBookingRideAPI()
            }else{
                self.upcomingCurrentPage = 1
                self.callUpcomingRideAPI()
            }
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch tableView {
        case self.tblMyRides:
            if self.arrRides.count != 0 {
                return UITableView.automaticDimension
            }else{
                return tableView.frame.height
            }
        case self.tblMyRideType:
            return UITableView.automaticDimension
        default:
            break
        }
        return UITableView.automaticDimension
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.tblMyRides.contentOffset.y >= (self.tblMyRides.contentSize.height - self.tblMyRides.frame.size.height)) && self.isStopPaging == false && self.isApiProcessing == false {
            print("call from scroll..")
            if(self.selectedMyRideState == 0){
                self.pastCurrentPage += 1
                self.upcomingCurrentPage = 1
                self.InProgressCurrentPage = 1
                self.callRideHistoryAPI()
                
            }else if(self.selectedMyRideState == 1){
                self.InProgressCurrentPage += 1
                self.pastCurrentPage = 1
                self.upcomingCurrentPage = 1
                self.callInProcessBookingRideAPI()
                
            }else{
                self.upcomingCurrentPage += 1
                self.pastCurrentPage = 1
                self.InProgressCurrentPage = 1
                self.callUpcomingRideAPI()
            }
        }
    }
    
}

//MARK:- Api Calls
extension MyRidesVC{
    
    func callRideHistoryAPI(){
        self.ridesViewModel.myRidesVC = self
        self.ridesViewModel.webserviceGetRideHistoryAPI(Page: "\(self.pastCurrentPage)")
    }
    
    func callUpcomingRideAPI(){
        self.ridesViewModel.myRidesVC = self
        self.ridesViewModel.webserviceGetUpcomingRideAPI(Page: "\(self.upcomingCurrentPage)")
    }
    
    func callInProcessBookingRideAPI(){
        self.ridesViewModel.myRidesVC = self
        self.ridesViewModel.webserviceInProcessBookingRideAPI(Page: "\(self.InProgressCurrentPage)")
    }
    
    func callAcceptBookingRideAPI(Id : String){
        self.ridesViewModel.myRidesVC = self
        let reqModel = RidesRequestModel()
        reqModel.bookingId = Id
        self.ridesViewModel.webserviceAcceptBookingRideAPI(reqModel: reqModel)
    }
}

//MARK:- AcceptBookingReqDelgate
extension MyRidesVC : AcceptBookingReqDelgate{
    func onAcceptBookingReq() {
        self.upcomingCurrentPage = 1
        self.callUpcomingRideAPI()
    }
}
