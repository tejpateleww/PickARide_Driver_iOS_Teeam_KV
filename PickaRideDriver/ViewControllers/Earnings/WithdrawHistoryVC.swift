//
//  WithdrawHistoryVC.swift
//  PickaRideDriver
//
//  Created by Gaurang on 02/09/22.
//

import UIKit

class WithdrawHistoryVC: BaseVC {
    
    static var newInstance: WithdrawHistoryVC {
        WithdrawHistoryVC.instantiate(fromAppStoryboard: .Earning)
    }
    @IBOutlet weak var tableView: UITableView!
    private var messageView: UIView?
    
    private var historyArray: [WithdrawInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarInViewController(controller: self, naviColor: colors.white.value,
                                         naviTitle: NavTitles.WithdrawHistory.value,
                                         leftImage: NavItemsLeft.back.value,
                                         rightImages: [], isTranslucent: false,
                                         CommonViewTitles: [], isTwoLabels: false)
        WithdrawHistoryCell.registerNib(to: tableView)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
            tableView.tableHeaderView = UIView()
        }
        setValue()
        fetchEarningHistory()
    }
    
    private func setValue() {
        tableView.isHidden = historyArray.isEmpty
        tableView.reloadData()
        messageView?.removeFromSuperview()
        messageView = nil
    }
    
    private func showNoData(_ message: String) {
        messageView = NoDataView.getInstance(message)
        guard let messageView = messageView else {
            return
        }
        view.addSubview(messageView)
        messageView.setAllSideContraints(.zero)
    }
    
    private func fetchEarningHistory() {
        Utilities.showHUD()
        WebServiceSubClass.getWithdrawHistory { (status, _, model, _) in
            Utilities.hideHUD()
            self.historyArray = model?.data ?? []
            self.setValue()
            if self.historyArray.isEmpty {
                self.showNoData("Data not available")
            }
        }
    }
}

extension WithdrawHistoryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        historyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WithdrawHistoryCell.cellId, for: indexPath) as! WithdrawHistoryCell
        cell.config(historyArray[indexPath.row])
        return cell
    }
    
}
