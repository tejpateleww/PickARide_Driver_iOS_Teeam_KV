//
//  MyRidesVC.swift
//  PickARide User
//
//  Created by baps on 16/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class MyRidesVC: BaseVC,UITableViewDelegate,UITableViewDataSource {
    //MARK: -Properties
    var myRideArr = ["UPCOMING","PAST"]
    var selectedMyRideState = 0
    //MARK: -IBOutlets
    
    @IBOutlet weak var btnUpcoming: MyRidesButton!
    
    @IBOutlet weak var viewTblRideType: UIView!
    @IBOutlet weak var lblMyRides: TitleLabel!
    @IBOutlet weak var tblMyRides: UITableView!
    @IBOutlet weak var tblMyRideType: UITableView!
    
    //MARK: -View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tblMyRides.delegate = self
        tblMyRideType.delegate = self
        tblMyRides.dataSource = self
        tblMyRideType.dataSource = self
        tblMyRideType.reloadData()
        tblMyRides.reloadData()
        self.viewTblRideType.isHidden = true
//        setupLocalization()
        print(tblMyRideType.contentSize.height)
        
        self.tblMyRideType.frame.origin.y = -8
        self.tblMyRideType.frame.size.height = 0
        setNavigationBarInViewController(controller: self, naviColor: colors.myride.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        self.btnUpcoming.setTitle(myRideArr[selectedMyRideState], for: .normal)
    }
    //MARK: -Other Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        switch tableView{
        case tblMyRides:
            return 6
        case tblMyRideType:
            return myRideArr.count
        default:
            return 2
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch tableView{
        case tblMyRides:
            let cell:MyRideCell = tblMyRides.dequeueReusableCell(withIdentifier: MyRideCell.reuseIdentifier, for: indexPath)as! MyRideCell
            return cell
        case tblMyRideType:
            
            print(cell.frame.size)
            let cell:pastUpcomingCell = tblMyRideType.dequeueReusableCell(withIdentifier: pastUpcomingCell.reuseIdentifier, for: indexPath)as! pastUpcomingCell
            cell.MyRidesLabel.text = myRideArr[indexPath.row]
            cell.imgDone.isHidden = true
            if indexPath.row == selectedMyRideState {
                cell.imgDone.isHidden = false
            }
            return cell
        default:
            print("Something is Wrong")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch tableView {
        case tblMyRides:
            if selectedMyRideState == 1 {
                let vc : RideDetailsVC = RideDetailsVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc : RideDetailsVC = RideDetailsVC.instantiate(fromAppStoryboard: .Main)
                vc.isFromUpcomming = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            break
        case tblMyRideType:
            selectedMyRideState = indexPath.row
            self.btnUpcoming.setTitle(myRideArr[selectedMyRideState], for: .normal)
            tblMyRideType.reloadData()
            setRideTableView()
        default:
            break
        }
    }
    //MARK: -IBActions
    @IBAction func btnMyRidesTap(_ sender: Any) {
        setRideTableView()
       
    }
    
    func setRideTableView() {
        if viewTblRideType.isHidden {
            
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
    
    
    //MARK: -API Calls
    
}
