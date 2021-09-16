//
//  MyRidesVC.swift
//  PickARide User
//
//  Created by baps on 16/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class MyRidesVC: BaseVC {
    
    //MARK: -IBOutlets
    @IBOutlet weak var btnUpcoming: MyRidesButton!
    @IBOutlet weak var viewTblRideType: UIView!
    @IBOutlet weak var tblMyRides: UITableView!
    @IBOutlet weak var tblMyRideType: UITableView!
    @IBOutlet weak var noDataView: UIView!
    
    //MARK: -Properties
    var pastCurrentPage = 0
    var upcomingCurrentPage = 0
    var isApiProcessing = false
    var isStopPaging = false
    var arrRides = [PastBookingResDatum]()
    var myRideArr = ["UPCOMING","PAST"]
    var selectedMyRideState = 1
    var ridesViewModel = RidesViewModel()
    
    //MARK: -View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareView()
        self.callRideHistoryAPI()
    }
    
    //MARK: - Custom methods
    func prepareView(){
        self.setNavigationBarInViewController(controller: self, naviColor: colors.myride.value, naviTitle: "My Rides", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        
        self.noDataView.isHidden = true
        
        self.tblMyRides.delegate = self
        self.tblMyRides.dataSource = self
        
        self.tblMyRideType.delegate = self
        self.tblMyRideType.dataSource = self
        self.tblMyRideType.frame.origin.y = -8
        self.tblMyRideType.frame.size.height = 0
        self.tblMyRideType.reloadData()
        self.viewTblRideType.isHidden = true
        
        self.btnUpcoming.setTitle(self.myRideArr[self.selectedMyRideState], for: .normal)
    }
    
    func setRideTableView() {
        if self.viewTblRideType.isHidden {
            self.viewTblRideType.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.btnUpcoming.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
                self.tblMyRideType.frame.size.height = self.tblMyRideType.contentSize.height * 2
            }, completion: {finished in
                self.tblMyRides.reloadData()
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnUpcoming.imageView?.transform = CGAffineTransform(rotationAngle: 0)
                self.tblMyRideType.frame.size.height = 0
            }, completion: {finished in
                self.viewTblRideType.isHidden = true
                self.tblMyRides.reloadData()
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
                self.noDataView.isHidden = true
                return self.arrRides.count
            } else {
                self.noDataView.isHidden = false
                return 0
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
            let cell:MyRideCell = self.tblMyRides.dequeueReusableCell(withIdentifier: MyRideCell.reuseIdentifier, for: indexPath)as! MyRideCell
            let dict = self.arrRides[indexPath.row]
            cell.lblAddress.text = dict.bookingInfo?.pickupLocation ?? ""
            cell.lblRideName.text = dict.bookingInfo?.vehicleName ?? ""
            cell.lblAmount.text = "$\(dict.bookingInfo?.driverAmount ?? "0")"
            
            let timestamp: TimeInterval =  Double(dict.bookingInfo?.acceptTime ?? "") ?? 0.0
            let date = Date(timeIntervalSince1970: timestamp)
            let formatedDate = date.timeAgoSinceDate(isForNotification: false)
            cell.lblDate.text = formatedDate 
            
            return cell
            
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
            if self.selectedMyRideState == 1 {
                let vc : RideDetailsVC = RideDetailsVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc : RideDetailsVC = RideDetailsVC.instantiate(fromAppStoryboard: .Main)
                vc.isFromUpcomming = true
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
                self.upcomingCurrentPage = 1
                self.callUpcomingRideAPI()
            }else{
                self.pastCurrentPage = 1
                self.callRideHistoryAPI()
            }
            
        default:
            break
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.tblMyRides.contentOffset.y >= (self.tblMyRides.contentSize.height - self.tblMyRides.frame.size.height)) && self.isStopPaging == false && self.isApiProcessing == false {
            print("call from scroll..")
            if(self.selectedMyRideState == 0){
                self.upcomingCurrentPage += 1
                self.pastCurrentPage = 1
                self.callUpcomingRideAPI()
            }else{
                self.pastCurrentPage += 1
                self.upcomingCurrentPage = 1
                self.callRideHistoryAPI()
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
}
