//
//  chatVC.swift
//  PickARide User
//
//  Created by Apple on 19/01/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ChatViewController: BaseVC {
    
    //MARK: -IBOutlets
    @IBOutlet weak var tblChat: UITableView!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    @IBOutlet weak var txtviewComment: ratingTextview!
    @IBOutlet var vwNavBar: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var btnSendMsg: UIButton!
    
    //MARK: -Properties
    var chatViewModel = ChatViewModel()
    var currentBookingModel : CurrentBookingDatum?
    var arrayChatHistory = [chatHistoryDatum]()
    var filterListArr : [String: [chatHistoryDatum]] = [String(): [chatHistoryDatum]()]
    var filterKeysArr : [Date] = [Date]()
    var oldChatSectionTitle = Date()
    var oldChatId = String()
    
    //MARK: -View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareView()
        self.setSenderProfileInfo()
        self.registerNIB()
        self.callChatHistoryAPI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.ChatSocketOnMethods()
        self.setupKeyboard(false)
        self.hideKeyboard()
        self.registerForKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.ChatSocketOffMethods()
        self.setupKeyboard(true)
        self.deregisterFromKeyboardNotifications()
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.enable = true
        
    }
    
    //MARK: - Button Action Methods
    @IBAction func btnSendMsgAction(_ sender: Any) {
        if validation() {
            
            let reqModel = sendMessageReqModel()
            reqModel.message = self.txtviewComment.text ?? ""
            reqModel.sender_id = SingletonClass.sharedInstance.UserId
            reqModel.sender_type = "driver"
            reqModel.receiver_id = self.currentBookingModel?.customerId ?? ""
            reqModel.receiver_type = "customer"
            reqModel.booking_id = self.currentBookingModel?.id ?? ""
            
            let param = reqModel.generatPostParams()
            if SocketIOManager.shared.socket.status == .connected {
                self.emitSocket_SendMessage(param: param)
            }
//            appendMessage()
            self.txtviewComment.text = ""
            
        }
    }
    
    func appendMessage(){
        
        let chatObj : chatHistoryDatum = chatHistoryDatum()
        
        chatObj.id = String(Int.random(in: 1...9999999))
        chatObj.bookingId = self.currentBookingModel?.id ?? ""
        chatObj.message =  self.txtviewComment.text ?? ""
        chatObj.receiverId =  self.currentBookingModel?.customerId ?? ""
        chatObj.receiverType = "customer"
        chatObj.senderId =  SingletonClass.sharedInstance.UserId
        chatObj.senderType = "driver"
      
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        chatObj.createdAt = dateFormatter.string(from: date)
        
        self.arrayChatHistory.append(chatObj)
        self.filterArrayData(isFromDidLoad: true)
        
    }
    
    func validation() -> Bool{
        if self.txtviewComment.text.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 || self.txtviewComment.text == "Type a message..." {
            Utilities.showAlertAction(message: "Please enter message", vc: self)
            return false
        }
        return true
    }
    
    
    //MARK: - Custom Methods
    func prepareView(){
//        self.tblChat.isHidden = true
        self.txtviewComment.delegate = self
        self.txtviewComment.textColor = self.txtviewComment.text == "" ? .black : .gray
        let strUrl = "\(APIEnvironment.Profilebu.rawValue)" + "\(self.currentBookingModel?.customerInfo?.profileImage ?? "")"
        self.setNavigationBarInViewController(controller: self, naviColor: colors.white.value, naviTitle: "", leftImage: NavItemsLeft.back.value, rightImages: [strUrl], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    
    func registerNIB(){
        tblChat.register(UINib(nibName:NoDataTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NoDataTableViewCell.reuseIdentifier)
    }
    
    func setSenderProfileInfo(){
        self.navigationItem.titleView = vwNavBar
        
        let custName = (self.currentBookingModel?.customerInfo?.firstName)! + " " + (self.currentBookingModel?.customerInfo?.lastName)!
        self.lblName.text = custName
        let NumberPlate = "\(self.currentBookingModel?.driverVehicleInfo?.plateNumber ?? "") - \(self.currentBookingModel?.driverVehicleInfo?.vehicleTypeManufacturerName ?? "") \(self.currentBookingModel?.driverVehicleInfo?.vehicleTypeModelName ?? "")"
        self.lblInfo.text = NumberPlate
        
        self.navBtnProfile.setImage(UIImage(named: "DummayUserPlaceHolder"), for: .normal)
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            if self.arrayChatHistory.count > 0 {
                let list = self.filterListArr[self.filterKeysArr.last?.Date_In_DD_MM_YYYY_FORMAT ?? String ()]
                
                let rowIndex = list?.count == 0 ? 0 : ((list?.count ?? 0) - 1)
                let indexPath = IndexPath(row: rowIndex, section: self.filterKeysArr.count - 1)
                self.tblChat.reloadData()
                self.tblChat.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
    }
    
    func scrollAt(){
        if self.arrayChatHistory.count > 0 {
            let list = self.filterListArr[oldChatSectionTitle.Date_In_DD_MM_YYYY_FORMAT ?? ""]
            let row = list?.firstIndex(where: {$0.id == oldChatId}) ?? 0
            let section = self.filterKeysArr.firstIndex(where: {$0.Date_In_DD_MM_YYYY_FORMAT == oldChatSectionTitle.Date_In_DD_MM_YYYY_FORMAT}) ?? 0
            let indexPath = IndexPath(row: row, section: section)
            self.tblChat.reloadData()
            self.tblChat.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
    func scrollToFirstRow() {
        self.tblChat.layoutIfNeeded()
        let indexPath = NSIndexPath(row: 0, section: 0)
        self.tblChat.scrollToRow(at: indexPath as IndexPath, at: .top, animated: false)
    }
    
    func filterArrayData(isFromDidLoad: Bool){
        self.filterListArr.removeAll()
        self.filterKeysArr.removeAll()
        self.arrayChatHistory.sort(by: {$0.createdAt!.compare($1.createdAt!) == .orderedAscending})
        for each in self.arrayChatHistory{
            let dateField = each.createdAt?.serverDateStringToDateType1?.Date_In_DD_MM_YYYY_FORMAT ?? String ()
            if filterListArr.keys.contains(dateField){
                filterListArr[dateField]?.append(each)
            }else{
                filterListArr[dateField] = [each]
                self.filterKeysArr.append(each.createdAt?.serverDateStringToDateType1 ?? Date())
            }
        }
        self.filterKeysArr.sort(by: <)
        isFromDidLoad ? self.scrollToBottom() : self.scrollAt()
    }
    
    
}

//MARK:- Textview Delegate
extension ChatViewController : UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        txtviewComment.text = txtviewComment.text ==  "Type a message..." ? "" : txtviewComment.text
        txtviewComment.textColor = .black
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        txtviewComment.textColor = txtviewComment.text == "" ? .gray : .black
        txtviewComment.text = txtviewComment.text == "" ? "Type a message..." : txtviewComment.text

    }
}

//MARK: -tableviewDelegate
extension ChatViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.arrayChatHistory.count > 0 {
            return self.filterKeysArr.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrayChatHistory.count > 0 {
            let strDate = self.filterKeysArr[section].Date_In_DD_MM_YYYY_FORMAT ?? ""
            return self.filterListArr[strDate]?.count ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height:30.0))
        if(self.arrayChatHistory.count > 0){
        
            let lblDate = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
            lblDate.backgroundColor = UIColor.lightGray
            lblDate.textColor = UIColor.white
            lblDate.layer.cornerRadius = lblDate.frame.height/2.0
            lblDate.layer.masksToBounds = true
            
            let obj = self.filterKeysArr[section]
            lblDate.text = obj.timeAgoSinceDate(isForNotification: true)
            
            lblDate.textAlignment = .center
            lblDate.font = FontBook.regular.of(size: 12.0)
            
            headerView.addSubview(lblDate)
            lblDate.center = headerView.center
        
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(self.arrayChatHistory.count > 0){
            let strDateTitle = self.filterKeysArr[indexPath.section].Date_In_DD_MM_YYYY_FORMAT ?? ""
            let obj = self.filterListArr[strDateTitle]?[indexPath.row]
            
            let isDriver = obj?.senderType ?? "" == "driver"
            if(isDriver){
                let cell = tblChat.dequeueReusableCell(withIdentifier: chatSenderCell.reuseIdentifier) as! chatSenderCell
                cell.selectionStyle = .none
                cell.lblSenderMessage.text = obj?.message ?? ""
                return cell
            }else{
                let cell = tblChat.dequeueReusableCell(withIdentifier: chatReciverCell.reuseIdentifier) as! chatReciverCell
                cell.selectionStyle = .none
                cell.lblReciverMessage.text = obj?.message ?? ""
                return cell
            }
        }else{
            let NoDatacell = self.tblChat.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
            return NoDatacell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.arrayChatHistory.count != 0 {
            return UITableView.automaticDimension
        }else{
            return tableView.frame.height
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}

//MARK:- Api Calls
extension ChatViewController{
    
    func callChatHistoryAPI(){
        self.chatViewModel.ChatCV = self
        let Id = self.currentBookingModel?.id ?? ""
        self.chatViewModel.webserviceGetChatHistoryAPI(strBookingID: Id)
    }
    
}

class chatSenderCell : UITableViewCell {
    
    @IBOutlet weak var lblBottomView: UIView!
    @IBOutlet weak var lblSenderView: chatScreenView!
    @IBOutlet weak var lblSenderMessage: chatScreenLabel!
}

class chatReciverCell : UITableViewCell {
    @IBOutlet weak var lblBottomView: UIView!
    @IBOutlet weak var lblReciverView: chatScreenView!
    @IBOutlet weak var lblReciverMessage: chatScreenLabel!
}

class chatHeaderCell : UITableViewCell {
    @IBOutlet weak var lblDateTime: chatScreenLabel!
}


//MARK: KEYBOARD SETUP FOR CHATBOX
extension ChatViewController {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboards))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboards()
    {
        view.endEditing(true)
    }
    
    func setupKeyboard(_ enable: Bool) {
        IQKeyboardManager.shared.enable = enable
        IQKeyboardManager.shared.enableAutoToolbar = enable
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = !enable
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        keyboardHeightLayoutConstraint?.constant = 0
        self.animateConstraintWithDuration()
    }
    
    @objc func keyboardWasShown(notification: NSNotification){
        
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        
        if #available(iOS 11.0, *) {
            
            DispatchQueue.main.async {
                if self.arrayChatHistory.count != 0 {
                    self.scrollToBottom()
                }
            }
            keyboardHeightLayoutConstraint?.constant = keyboardSize!.height - view.safeAreaInsets.bottom
            
        } else {
            
            DispatchQueue.main.async {
                if self.arrayChatHistory.count != 0 {
                    self.scrollToBottom()
                }
            }
            keyboardHeightLayoutConstraint?.constant = keyboardSize!.height - 10
            
        }
        self.animateConstraintWithDuration()
    }
    
    func deregisterFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func animateConstraintWithDuration(duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.loadViewIfNeeded() ?? ()
        })
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

